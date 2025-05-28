.model small

.data
    file db  "C:\TEXT.TXT",0    
    success db "File created $" 
    var1 db "It is $" 
    time_am db " AM Currently$"
    time_pm db " PM Currently$"
    time db 4 DUP('$') 
    time2 db 4 DUP('$')
    buffer db 100
    buffer2 db 8 DUP('$')
    var2 dw 0
    members db "-----THIS ENCRYPTION PROJECT WAS MADE BY-----", 10, 13,10, 13, "ABDUL MOEEZ NAEEM MALIK", 10, 13, 10, 13, "$"
    welcome db "-----WELCOME TO ENCRYPTION PROJECT-----$"
    choice1 db 10, 13, "Press 1 to encrypt text.$"
    choice2 db 10, 13, "Press 2 to decrypt text.$" 
    endchoice db 10, 13, "Press 0 to end program.", 10, 13, "$"
    choice3 db 10, 13, "Enter the text to encrypt.", 10, 13, "$"     
    choice4 db 10, 13, "Here is the decrypted text.$", 10, 13, "$"
    prompt db 10d, 13d, "Enter text: $"
    prompt2 db 10d, 13d, "Here is the encrypted text in file.", 10, 13, "$"
    error db 10d, 13d, "Error! Press any key to continue$"
    nl db 10d, 13d, "$"  
    var db "$" 
                     
                                  
.code 
    mov ax, @data       
    mov ds, ax
    
menu:
    mov ah, 09h         
    lea dx, welcome      
    int 21h  
    mov ah, 09h         
    lea dx, choice1      
    int 21h 
    mov ah, 09h         
    lea dx, choice2      
    int 21h 
    mov ah, 09h         
    lea dx, endchoice      
    int 21h 
    mov ah, 01h
    int 21h
    cmp al, 31h
    je choice_1
    cmp al, 32h
    je prep_dec 
    cmp al, 30h
    je end_prog 
    mov ah, 09h         
    lea dx, error      
    int 21h      
    mov ah, 07h
    int 21h 
    mov ah, 08h        
    int 21h 
    jmp cls
    
take_inp:  
    mov ah, 01h         
    int 21h            
    cmp al, 13          
    je disp_inp    
    mov [si], al          
    inc si              
    jmp take_inp           

disp_inp:
    mov [si], '$'  
    jmp prep_enc  
    
prep_enc: 
    mov si, offset var
    mov ah, 09h 
    lea dx, nl 
    mov si, offset var
    mov ah, 09h 
    lea dx, prompt2
    int 21h 
    jmp encrypt 

encrypt:
    cmp [si], '$'
    je display_enc
    add [si], 4
    inc si
    jmp encrypt 
    
decrypt:
    cmp [si], '$'
    je display_dec
    sub [si], 4
    inc si
    mov cl, 1
    jmp decrypt
    
    
display_enc: 
    mov ah, 09h   
    lea dx, var
    int 21h
    mov ah, 01h   
    int 21h
    jmp write
    jmp cls

display_dec:
    mov ah, 09h   
    lea dx, nl
    int 21h
    mov ah, 09h   
    lea dx, var
    int 21h
    mov ah, 01h   
    int 21h
    jmp cls
      
choice_1: 
    mov si, offset var  
    mov ah, 09h         
    mov dx, offset nl      
    int 21h
    mov ah, 09h 
    lea dx, choice3
    int 21h  
    jmp take_inp  
                    
                    
prep_dec:
  jmp read 

choice_2:
    mov si, offset var  
    mov ah, 09h         
    mov dx, offset nl      
    int 21h
    mov ah, 09h 
    lea dx, choice4
    int 21h
    jmp decrypt  
    
cls:  
    mov ax, 3
    int 10h  
    jmp menu
    
write:
    ; Open the file for writing
    lea dx, file     
    mov ah, 3Ch          ; Function to open/create a file
    int 21h             
    mov bx, ax         

    ; Write variable to the file
    lea dx, var         
    mov cx, 5          
    mov ah, 40h          ; Function to write to a file
    int 21h             

    ; Close the file
    mov ah, 3Eh          ; Function to close a file
    mov bx, ax           ; Move file handle to BX register
    int 21h              
    jmp cls
    
read:
    ; Open the file for reading
    lea dx, file     
    mov ah, 3Dh          ; Function to open a file
    mov al, 0            ; Open for reading (AL = 0)
    int 21h             
    mov bx, ax     

    ; Read a byte of data from the file into the buffer
    lea dx, buffer      
    mov cx, 5            ; Number of bytes to read (single byte)
    mov ah, 3Fh          ; Function to read from a file
    int 21h
    mov di, offset buffer           
    mov si, offset var
    mov ah, 09h
    
    recall:
    mov al, [di] 
    cmp al, '-'  
    je close
    mov [si], al          
    inc si 
    inc di
    jmp recall

    close:
    mov [si], '$'
    mov ah, 3Eh          ; Function to close a file
    mov bx, ax           ; Move file handle to BX register
    int 21h              ; Call interrupt to close the file

    mov ah, 09h         
    lea dx, prompt2
    int 21h 
    mov ah, 09h        
    lea dx, var
    int 21h 
    jmp choice_2

end_prog:
    mov ax, 3
    int 10h
    mov si, 0
    mov ah, 09h         
    lea dx, nl      
    int 21h
    mov ah, 09h
    lea dx, members
    int 21h 
    
    mov ah, 09h
    lea dx, var1
    int 21h    
    
    mov ah, 2ch 
    int 21h 
    mov al, ch
    aam
    mov bx, ax
    mov di, offset time
    jmp disp
    
min:       
    mov al, cl
    aam
    mov bx, ax
    mov di, offset time2 
    jmp disp2

    
disp:
    add bh, 30h
    mov [di], bh        
    add bl, 30h 
    inc di
    mov [di], bl 
    jmp min
    
disp2:
    add bh, 30h
    mov [di], bh        
    add bl, 30h 
    inc di
    mov [di], bl    
    

func:    
    mov bh, ch
    cmp bh, 0h
    je AM
    sub bh, 12
    jc AM 
    mov bh, ch
    sub bh, 12
    jz PM
    jmp PM
    
AM:
    mov ah, 09h
    lea dx, time
    int 21h 
    mov ah, 02h
    mov dl, ':'
    int 21h 
    mov ah, 09h
    lea dx, time2
    int 21h
    mov ah, 09h
    lea dx, time_am
    int 21h
    mov ah, 4ch
    int 21h      
       

PM: 
    sub time, 12
    mov ah, 02h
    int 21h
    mov ah, 02h
    mov dl, ':'
    int 21h 
    mov ah, 09h
    lea dx, time2
    int 21h
    mov ah, 09h
    lea dx, time_pm
    int 21h
    mov ah, 4ch
    int 21h
    
       int 21h
    mov ah, 09h
    lea dx, time_pm
    int 21h
    mov ah, 4ch
    int 21h
    
    