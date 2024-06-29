StreamToFormData(stream, boundary) {
       ; Cria o boundary se não for fornecido
       if !boundary
           boundary := "----WebKitFormBoundary" A_TickCount A_Now

       formData := ""

       ; Cria a parte do cabeçalho do form data
       formData .= "--" boundary "`r`n"
       ;formData .= "Content-Disposition: form-data; name=""" stream.name """; filename=""file.bin""`r`n"
       formData .= 'Content-Disposition: form-data; name="' stream.name '"; filename=""file.bin""`r`n'

       formData .= "Content-Type: application/octet-stream`r`n`r`n"

       ; Lê do stream e adiciona ao form data
       while !stream.AtEOF {
           buffer := stream.Read(1024)  ; Ajuste o tamanho do buffer conforme necessário
           formData .= buffer
       }

       ; Cria a parte do rodapé do form data
       formData .= "`r`n--" boundary "--`r`n"

       ; Retorna o form data completo e o boundary
       return {formData: formData, boundary: boundary}
   }