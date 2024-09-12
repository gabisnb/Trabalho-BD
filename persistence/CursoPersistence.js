import { PrismaClient } from "@prisma/client";
import { getAllAulasByCursoId } from "./AulaPersistence.js";

const prisma = new PrismaClient();

//! Curso Persistence

/**
 * 
 * @returns all cursos in the database
 */
async function getAllCursos() {
    const cursos = await prisma.curso.findMany();
    return cursos;
}

/**
 * 
 * @param {String} id 
 * @returns curso with the given id
 */
async function cursoById(id) {
    let curso = await prisma.curso.findUnique({
        where: {
            id_curso: id
        }
    });

    let aulas = null;
    aulas = await getAllAulasByCursoId(curso.id_curso);
    return {
        curso: curso,
        aulas: aulas
    };
}

/**
 * 
 * @param {String} nome 
 * @returns curso with the given name
 */
async function cursoByNome(nome) {
    let curso = await prisma.curso.findUnique({
        where: {
            nome_curso: nome
        }
    });

    let aulas = null;
    aulas = await getAllAulasByCursoId(curso.id_curso);
    return {
        curso: curso,
        aulas: aulas
    };
}

/**
 * 
 * @param {String} area_id 
 * @returns 
 */
async function cursosByAreaId(area_id){
    let curso = await prisma.curso.findMany({
        where: {
            id_area: area_id
        }
    });
    return curso;
}

export { getAllCursos, cursoById, cursoByNome, cursosByAreaId };
