import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/database.service';

@Injectable()
export class CursoService {
    constructor(private readonly prismaService: PrismaService){

    }

    async getAllCurso(){
        try{
            return await this.prismaService.curso.findMany({
                include: {
                    area: true,
                }
            });
        }
        catch(e){
            throw e;
        }
    }

    async getAulaByCursoId(id: string){
        try{
            return await this.prismaService.aula.findMany({
                where: {
                    id_curso: id
                }
            });
        }
        catch(e){
            throw e;
        }
    }
}
