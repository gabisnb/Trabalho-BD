import { Controller, Get, HttpException, HttpStatus, Param } from '@nestjs/common';
import { UsuarioService } from './usuario.service';

@Controller('usuario')
export class UsuarioController {
  constructor(private readonly usuarioService: UsuarioService) {}

  @Get("login/:email/:senha")
  async getUser(@Param('email') email : string, @Param('senha') senha : string ){
    try{
      return await this.usuarioService.getUser(email, senha);
    }
    catch(e){
      throw new HttpException(
        {
          status: 'userError',
          message: 'Usuário não encontrado',
        },
        HttpStatus.NOT_FOUND,
      );
    }
    // localhost 3000
  }
}
