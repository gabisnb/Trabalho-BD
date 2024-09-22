import { PrismaService } from 'src/database/database.service';
export declare class UsuarioService {
    private readonly prismaService;
    constructor(prismaService: PrismaService);
    getUser(email: string, senha: string): Promise<{
        id_usuario: string;
        nome_usuario: string;
        email: string;
        senha: string;
    }>;
}
