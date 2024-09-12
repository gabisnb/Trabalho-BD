import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient()

//! User Persistence

/**
 * 
 * @returns all users in the database
 */
async function allUsers() {
  const users = await prisma.usuario.findMany();
  return users;
}

/**
 * 
 * @param {String} id 
 * @returns user with the given id
 */
async function userById(id) {
  const user = await prisma.usuario.findUnique({
    where: {
      id_usuario: id
    }
  });
  return user;
}

/**
 * 
 * @param {String} email 
 * @param {String} senha 
 * @returns user with the given email and password
 */
async function userByCredentials(email, senha){
  let user = await prisma.usuario.findUnique({
    where: {
      email: email,
      senha: senha
    }
  });

  let type = await getUserType(user);

  return {
    user: user,
    type: type
  };
}

/**
 * 
 * @param {prisma.usuario} user 
 * @returns the type of user (administrador or estudante)
 */
async function getUserType(user){
  if(user == null || user == undefined)
    return null;

  let isAdmin = await prisma.administrador.findUnique({
    where: {
      id_usuario: user.id_usuario
    }
  }) != null;
  if(isAdmin)
    return 'administrador';

  return 'estudante';
}

/**
 * Creates a new user with the given parameters
 * @param {String} id 
 * @param {String} nome 
 * @param {String} email 
 * @param {String} senha 
 */
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

export { userById, allUsers, userByCredentials, getUserType, createUser};