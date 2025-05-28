# Blackies DB


## Comandos de docker

### Levantar los servicios (crear y arrancar los contenedores)
```sh
docker-compose up
```

### Levantar los servicios en segundo plano (modo detached)
```sh
docker-compose up -d
```

### Detener y eliminar los contenedores, redes y volúmenes creados por Docker Compose
```sh
docker-compose down
```

### Detener y eliminar también los volúmenes de datos
```sh
docker-compose down -v
```

---

## Conexión a la base de datos MySQL

Puedes conectarte a la base de datos MySQL con los siguientes datos:

- **Host:** localhost  
- **Puerto:** 3307  
- **Usuario:** root  
- **Contraseña:** 12345  

Ejemplo de conexión desde la terminal:

```sh
mysql -h 127.0.0.1 -P 3307 -u root -p
```
Luego ingresa la contraseña `12345` cuando se te solicite.