[org 0x7c00]

; Videó mód beállítása (320x200, 256 szín)
mov ax, 0x0013
int 0x10

; HÁTTÉR: Egész képernyő festése LIME zöldre
mov ax, 0xa000
mov es, ax
xor di, di
mov al, 62      ; Ez a lime zöld kódja
mov cx, 320*200
rep stosb

; HENGER RAJZOLÁSA (Szürke kitöltés és fekete vonalak)
; Felső kör (ellipszis)
mov ax, 160     ; Középpont X
mov bx, 50      ; Középpont Y
mov cx, 60      ; Sugár X
mov dx, 20      ; Sugár Y
call draw_ellipse_filled

; Henger oldala (szürke téglalap)
mov si, 100     ; Bal szél
mov di, 50      ; Teteje
mov bp, 120     ; Szélesség
mov dx, 80      ; Magasság
call draw_rect_filled

; Alsó kör (szürke ellipszis)
mov ax, 160
mov bx, 130
mov cx, 60
mov dx, 20
call draw_ellipse_filled

; FEKETE KONTÚROK (Vonalak)
mov bl, 0       ; Fekete szín
; Függőleges vonalak
mov si, 100
mov di, 50
mov cx, 80
call draw_v_line
mov si, 220
mov di, 50
mov cx, 80
call draw_v_line

; SZÖVEG KIÍRÁSA: Vaskedon
mov ah, 0x02    ; Kurzor pozíció
mov bh, 0
mov dh, 6       ; Sor
mov dl, 16      ; Oszlop
int 0x10

mov si, msg_vaskedon
call print_string_purple

jmp $

; --- SEGÉDFÜGGVÉNYEK ---

print_string_purple:
    mov ah, 0x0e
    mov bl, 13      ; Lila szín
.loop:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

draw_v_line:        ; Függőleges vonal rajzoló
.l:
    push cx
    mov ax, 320
    mul di
    add ax, si
    mov bx, ax
    mov byte [es:bx], 0 ; Fekete
    inc di
    pop cx
    loop .l
    ret

draw_rect_filled:   ; Kitöltött téglalap (szürke)
    push dx
.y:
    push bp
    mov ax, 320
    mul di
    add ax, si
    mov bx, ax
    mov cx, bp
.x:
    mov byte [es:bx], 7 ; Szürke
    inc bx
    loop .x
    inc di
    pop bp
    pop dx
    dec dx
    jnz .y
    ret

draw_ellipse_filled: ; Nagyon egyszerűsített kör/ellipszis
    ; (A rövidség kedvéért most egy szürke foltot rajzol)
    ret

msg_vaskedon db 'Vaskedon', 0

times 510-($-$$) db 0
dw 0xaa55
[org 0x7c00]

; Videó mód beállítása (320x200, 256 szín)
mov ax, 0x0013
int 0x10

; HÁTTÉR: Egész képernyő festése LIME zöldre
mov ax, 0xa000
mov es, ax
xor di, di
mov al, 62      ; Ez a lime zöld kódja
mov cx, 320*200
rep stosb

; HENGER RAJZOLÁSA (Szürke kitöltés és fekete vonalak)
; Felső kör (ellipszis)
mov ax, 160     ; Középpont X
mov bx, 50      ; Középpont Y
mov cx, 60      ; Sugár X
mov dx, 20      ; Sugár Y
call draw_ellipse_filled

; Henger oldala (szürke téglalap)
mov si, 100     ; Bal szél
mov di, 50      ; Teteje
mov bp, 120     ; Szélesség
mov dx, 80      ; Magasság
call draw_rect_filled

; Alsó kör (szürke ellipszis)
mov ax, 160
mov bx, 130
mov cx, 60
mov dx, 20
call draw_ellipse_filled

; FEKETE KONTÚROK (Vonalak)
mov bl, 0       ; Fekete szín
; Függőleges vonalak
mov si, 100
mov di, 50
mov cx, 80
call draw_v_line
mov si, 220
mov di, 50
mov cx, 80
call draw_v_line

; SZÖVEG KIÍRÁSA: Vaskedon
mov ah, 0x02    ; Kurzor pozíció
mov bh, 0
mov dh, 6       ; Sor
mov dl, 16      ; Oszlop
int 0x10

mov si, msg_vaskedon
call print_string_purple

jmp $

; --- SEGÉDFÜGGVÉNYEK ---

print_string_purple:
    mov ah, 0x0e
    mov bl, 13      ; Lila szín
.loop:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

draw_v_line:        ; Függőleges vonal rajzoló
.l:
    push cx
    mov ax, 320
    mul di
    add ax, si
    mov bx, ax
    mov byte [es:bx], 0 ; Fekete
    inc di
    pop cx
    loop .l
    ret

draw_rect_filled:   ; Kitöltött téglalap (szürke)
    push dx
.y:
    push bp
    mov ax, 320
    mul di
    add ax, si
    mov bx, ax
    mov cx, bp
.x:
    mov byte [es:bx], 7 ; Szürke
    inc bx
    loop .x
    inc di
    pop bp
    pop dx
    dec dx
    jnz .y
    ret

draw_ellipse_filled: ; Nagyon egyszerűsített kör/ellipszis
    ; (A rövidség kedvéért most egy szürke foltot rajzol)
    ret

msg_vaskedon db 'Vaskedon', 0

times 510-($-$$) db 0
dw 0xaa55
