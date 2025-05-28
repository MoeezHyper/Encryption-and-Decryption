# Encryption-and-Decryption
Encryption and Decryption in Assembly Language with File Handling (8086 emu)

🔐 Encryption Project in x86 Assembly (DOS)
This x86 Assembly project is an encryption/decryption utility built for 8086 emu. It performs text manipulation by adding/subtracting a fixed value (Caesar cipher style), reads from/writes to a file (C:\TEXT.TXT), and includes a text-based menu system.

✨ Features:
-Menu-driven interface using DOS interrupt calls.
-Simple Caesar cipher encryption (+4) and decryption (−4).
-File I/O for saving and retrieving encrypted text.
-Time display and personalized credit output.
-Uses BIOS and DOS interrupts for display and I/O.

🛠️ Functions:
-encrypt: Adds 4 to ASCII value of each character.
-decrypt: Subtracts 4 to restore original text.
-write: Writes encrypted text to file.
-read: Reads text from file and decrypts it.
-Displays current time with AM/PM suffix using INT 21h and INT 10h.
