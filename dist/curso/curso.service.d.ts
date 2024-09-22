import { PrismaService } from 'src/database/database.service';
export declare class CursoService {
    private readonly prismaService;
    constructor(prismaService: PrismaService);
    getAllCurso(): Promise<{
        id_curso: string;
        nome_curso: string;
        descricao_curso: string | null;
        id_area: string | null;
        id_usuario: string | null;
    }[]>;
}
