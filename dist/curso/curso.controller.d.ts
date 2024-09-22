import { CursoService } from './curso.service';
export declare class CursoController {
    private readonly cursoService;
    constructor(cursoService: CursoService);
    getAllCurso(): Promise<({
        area: {
            id_area: string;
            nome_area: string;
            descricao_area: string | null;
        };
    } & {
        id_curso: string;
        nome_curso: string;
        descricao_curso: string | null;
        id_area: string | null;
        id_usuario: string | null;
    })[]>;
    getAulaByCursoId(id: string): Promise<{
        id_aula: string;
        nome_aula: string;
        resumo_aula: string | null;
        professor: string | null;
        duracao_aula: number | null;
        url_video: string | null;
        id_curso: string | null;
        id_usuario: string | null;
    }[]>;
}
