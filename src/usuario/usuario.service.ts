import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/database.service';

@Injectable()
export class UsuarioService {
    constructor(private readonly prismaService: PrismaService){
        
    }

    async getUser(email: string, senha: string){
      try{
        const user = this.prismaService.usuario.findUnique({
            where: {
              email: email,
              senha: senha
            }
          });

          if(!user)
            throw new Error("Usuário não encontrado");
          return user;
      }
      catch(e){
        console.log(e.message);
      }
    }
}
