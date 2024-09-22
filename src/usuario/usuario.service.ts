import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/database.service';
import { LoginDto } from './dto/login.dto';
import { error } from 'console';

@Injectable()
export class UsuarioService {
    constructor(private readonly prismaService: PrismaService){
        
    }

    async getUser(body: LoginDto){
      try{
        const user = this.prismaService.usuario.findUnique({
          where: {
            email: body.email,
            senha: body.senha,
          },
        });
        return user;
      }
      catch(e){
        throw e;
      }
    }
}
