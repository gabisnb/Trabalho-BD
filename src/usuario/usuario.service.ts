import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/database.service';

@Injectable()
export class UsuarioService {
    constructor(private readonly prismaService: PrismaService){
        
    }

    async getUser(email: string, senha: string){
        return this.prismaService.usuario.findUnique({
            where: {
              email: email,
              senha: senha
            }
          });
    }
}
