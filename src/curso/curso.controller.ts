import { Controller, Get } from '@nestjs/common';
import { CursoService } from './curso.service';

@Controller('curso')
export class CursoController {
  constructor(private readonly cursoService: CursoService) {}

  @Get('')
  async getAllCurso(){
    return this.cursoService.getAllCurso();
  }
}
