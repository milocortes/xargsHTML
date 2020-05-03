# Uso de `xargs` para filtrar archivos html

El comando `xargs` es un comando de Unix utilizado para construir y ejecutar comandos desde una entrada standar.
Este convierte las entradas en argumento de  un comando.

Una característica interesante es que algunos comandos de `xargs`  pueden ser ejecutados en paralelo (`-P max_procs`).

El comando corre hasta `max_procs` procesos a la vez,max_procs teniendo como default uno. Si `max_procs`  es 0, `xargs` correrá tantos procesos como sean posibles a la vez.

Para implementar el comando `xargs`, definimos una función `filtro` que acepta un archivo y elimina la expresión regular `s/<.*>//`:

```bash
#!/bin/bash

filtro(){
     sed 's/<.*>//' $1  > $1.txt
}

filtro $1
```    

Esta función se utiliza junto con el comando `xargs` para quitar las etiquetas html
a un data set que tiene 27,888 archivos html sobre descripciones de pelı́cula([liga](http://www.cs.cornell.edu/people/pabo/movie-review-data/)).


El siguiente archivo bash almacena los tiempos de ejecución para distintos valores de procesos paralelos en un archivo de texto.

```bash
#!/bin/bash
touch output_time_cpp.txt

for i in  1 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70
do
echo "************************************" >>output_time_cpp.txt
echo "Threads "$i >>output_time_cpp.txt

( time find . -iname "*.html" | xargs -l -P $i filtro) 2>>output_time_cpp.txt

rm *.html.txt

done
```

Se presentan las gráficas del Speed-Up y de eficiencia. Podemos observar que con pocos procesos el Speed-up alcanza su lı́mite (rondando el 2.3). Por su
parte, la eficiencia nos indica que no hay un buen desempeño pues sólo con 2 y 4 procesos la eficiencia es mayor al 50%.

![Speed-Up](speedUpTarea02.eps)
![Eficiencia](eficienciaTare02.eps)
