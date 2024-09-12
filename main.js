import { PrismaClient } from '@prisma/client';
import { userByCredentials, getUserType } from './userPersistence.js';
import { getActiveAssinaturaByEstudanteId } from './assinaturaPersistence.js';

const prisma = new PrismaClient()

async function main() {
  var userList = undefined;
  // var userType = undefined;
  // ... you will write your Prisma Client queries here
  // const userList = await userById('user2');
  // const userList = await allUsers();
  userList = await userByCredentials('maria.oliveira@email.com', 'senha456');
  // userType = await getUserType(userList);
  console.log(userList.user);
  console.log('Tipo: ' + userList.type);

  var assinatura = await getActiveAssinaturaByEstudanteId(userList.user.id_usuario);
  console.log(assinatura);
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