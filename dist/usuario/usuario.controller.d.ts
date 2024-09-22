import { UsuarioService } from './usuario.service';
import { LoginDto } from './dto/login.dto';
export declare class UsuarioController {
    private readonly usuarioService;
    constructor(usuarioService: UsuarioService);
    getUser(body: LoginDto): Promise<{
        id_usuario: string;
        nome_usuario: string;
        email: string;
        senha: string;
    }>;
}
