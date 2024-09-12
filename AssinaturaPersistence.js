import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient()

//! Assinatura Persistence

/**
 * 
 * @param {String} estudante_id 
 * @returns 
 */
async function getAllAssinaturasByEstudanteId(estudante_id) {
    let assinaturas = await prisma.assinatura.findMany({
        where: {
            id_usuario: estudante_id
        },
    })
  
    return assinaturas;
}

/**
 * 
 * @param {String} estudante_id 
 * @returns last assinatura of the student with the given id
 */
async function getLastAssinaturaByEstudanteId(estudante_id) {
    let assinatura = await prisma.assinatura.findFirst({
        where: {
            id_usuario: estudante_id
        },
    })
  
    return assinatura;
}
  
/**
 * 
 * @param {String} estudante_id 
 * @returns 
 */
async function getActiveAssinaturaByEstudanteId(estudante_id) {
    let assinatura = await prisma.assinatura.findFirst({
        where: {
            id_usuario: estudante_id,
            data_inicio:{
                lt: new Date() //less than
            },
            data_fim: {
                gt: new Date() //greater than
            }
        },
    })
  
    return assinatura;
}

export { getAllAssinaturasByEstudanteId, getLastAssinaturaByEstudanteId, getActiveAssinaturaByEstudanteId };