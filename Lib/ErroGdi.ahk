Class ErroGdi {
    static GdiErrors := Map(
        0, "Indica que a chamada de método foi bem-sucedida.",
        1, "Indica um erro genérico na chamada de método.",
        2, "Indica que um dos argumentos passados não era válido.",
        3, "Indica falta de memória no sistema.",
        4, "Indica que o objeto especificado está ocupado.",
        5, "Indica buffer insuficiente.",
        6, "Indica método não implementado.",
        7, "Indica erro Win32.",
        8, "Indica estado incorreto do objeto.",
        9, "Indica que o método foi abortado.",
        10, "Indica que o arquivo não foi encontrado.",
        11, "Indica estouro de valor.",
        12, "Indica acesso negado.",
        13, "Indica formato de imagem desconhecido.",
        14, "Indica que a família de fontes não foi encontrada.",
        15, "Indica que o estilo de fonte não foi encontrado.",
        16, "Indica que a fonte não é TrueType.",
        17, "Indica versão não suportada do GDI+.",
        18, "Indica que o GDI+ não está inicializado.",
        19, "Indica que a propriedade não foi encontrada.",
        20, "Indica que a propriedade não é suportada.",
        21, "Indica que o perfil de cor não foi encontrado."
    )
    __New( Error, fn ) {
        if ( Error > 0 && Error <= 21 ) {
            Errod := ErroGdi.GdiErrors[ Error ] "`n" fn.Name
            throw( Errod )
        } else if ( Error > 21 ) {
            throw( "Erro desconhecido." )
        }
        this.GdiErrors := 0 
    }

    __Delete() {
        
    }
    
}
