const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

async function main() {
  // ... you will write your Prisma Client queries here
  const userList = await userById('user2');
  // const userList = await allUsers();
  console.log(userList);
}

async function allUsers() {
  const users = await prisma.usuario.findMany();
  return users;
}

async function userById(id) {
  const user = await prisma.usuario.findUnique({
    where: {
      id_usuario: id
    }
  });
  return user;
}

async function createUser(id, nome, email, senha) {
  const newUser = await prisma.usuario.create(
    {
      data: {
        id_usuario: id,
        nome_usuario: nome,
        email: email,
        senha: senha
      }
    }
  );
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