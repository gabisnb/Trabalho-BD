import { prisma } from "./persistence/db.server.js";
import { userByCredentials, getUserType, allUsers } from './persistence/UserPersistence.js';
import { getActiveAssinaturaByEstudanteId } from './persistence/AssinaturaPersistence.js';
import { cursoById, getAllCursos, cursosByAreaId } from './persistence/CursoPersistence.js';

async function main() {
  // var cursoList;

  // cursoList = await getAllCursos();
  // cursoList = await cursoByAreaId('area_ti');
  // cursoList = await cursoById('curso_java');
  // console.log(cursoList.curso);
  // console.log(cursoList.aulas);
  var users = await allUsers();
  console.log(users);
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