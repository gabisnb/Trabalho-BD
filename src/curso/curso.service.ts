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
}
