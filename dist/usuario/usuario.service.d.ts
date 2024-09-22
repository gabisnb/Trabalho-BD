import { PrismaService } from 'src/database/database.service';
import { LoginDto } from './dto/login.dto';
export declare class UsuarioService {
    private readonly prismaService;
    constructor(prismaService: PrismaService);
    getUser(body: LoginDto): Promise<{
        id_usuario: string;
        nome_usuario: string;
        email: string;
        senha: string;
    }>;
}
