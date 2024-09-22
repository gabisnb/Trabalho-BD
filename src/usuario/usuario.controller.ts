import { Body, Controller, Get, HttpException, HttpStatus, Param, Post } from '@nestjs/common';
import { UsuarioService } from './usuario.service';
import { LoginDto } from './dto/login.dto';

@Controller('usuario')
export class UsuarioController {
  constructor(private readonly usuarioService: UsuarioService) {}

  @Post("/login")
  async getUser(@Body() body:LoginDto){
    try{
      const user = await this.usuarioService.getUser(body);

      if(!user){
        throw new HttpException('Usuário não encontrado', HttpStatus.NOT_FOUND);
      }

      return user;
    }
    catch(e){
      console.log(e);
      throw e;
    }
  }
}
