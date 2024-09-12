import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

//! Aula Persistence

async function getAllAulasByCursoId(curso_id) {
    var aulas = prisma.aula.findMany({
        where: {
            id_curso: curso_id
        }
    })

    return aulas;
}

export { getAllAulasByCursoId };