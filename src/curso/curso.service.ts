import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/database.service';

@Injectable()
export class CursoService {
    constructor(private readonly prismaService: PrismaService){

    }

    async getAllCurso(){
        return this.prismaService.curso.findMany();
    }
}
