import { Module } from '@nestjs/common';
import { CursoService } from './curso.service';
import { CursoController } from './curso.controller';
import { PrismaService } from 'src/database/database.service';

@Module({
  controllers: [CursoController],
  providers: [CursoService, PrismaService],
})
export class CursoModule {}
