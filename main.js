import { PrismaClient } from '@prisma/client';
import { userByCredentials, getUserType } from './persistence/UserPersistence.js';
import { getActiveAssinaturaByEstudanteId } from './persistence/AssinaturaPersistence.js';
import { cursoById, getAllCursos, cursosByAreaId } from './persistence/CursoPersistence.js';

const prisma = new PrismaClient()

async function main() {
  var cursoList;

  // cursoList = await getAllCursos();
  // cursoList = await cursoByAreaId('area_ti');
  cursoList = await cursoById('curso_java');
  console.log(cursoList.curso);
  console.log(cursoList.aulas);
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })