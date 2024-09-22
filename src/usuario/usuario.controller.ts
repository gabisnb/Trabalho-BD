import { Controller, Get, Param } from '@nestjs/common';
import { UsuarioService } from './usuario.service';

@Controller('usuario')
export class UsuarioController {
  constructor(private readonly usuarioService: UsuarioService) {}

  @Get("/getByCredentials")
  async getUser(@Param('email') email : string, @Param('senha') senha : string ){
    return this.usuarioService.getUser(email, senha);
    // localhost 3000
  }
}
