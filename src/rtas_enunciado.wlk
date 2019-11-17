/*
 * 1) Ataques 
 * a) Seleccionar de un grupo sus atacantes, es decir, aquellos integrantes que           
 * pueden atacar. 
 * 
 * grupo.atacantes()
 * 
 * b) Hacer que una persona ataque a un caminante y que pase lo que deba              
 * pasar. 
 * 
 * sobreviviente.atacar(caminante)
 * 
 * c) Calcular el poder ofensivo de un grupo, que es igual al total del poder              
 * ofensivo de sus atacantes por un extra dado en base al carisma del líder. 
 * 
 * grupo.poderesOfensivos()
 
2) Aprovisionamiento 
* a) Hacer que dado un sobreviviente consuma una guarnición curadora (con sus           
* efectos).
* 
* sobreviviente.estado().comer(self)
* 
* b) Hacer que un sobreviviente se haga propietario de un conjunto de armas.
* 
* sobreviviente.armas().add(_armas) 
 
3) Toma de lugares 
* a) Saber si un grupo de sobrevivientes puede tomar un lugar.
* 
* grupo.puedenTomar(lugar)
* 
*  b) Identificar de un grupo de sobrevivientes, el integrante más débil, es decir,            
* aquel que el poder ofensivo es el menor entre todos. 
* 
* grupo.masDebil()
* 
* c) Hacer que un grupo de sobrevivientes tome un lugar, en caso de poder tiene              
* que: 
* i) Moverse hasta ahí. 
* ii) Atacar a los caminantes del lugar. Cuando el grupo tiene que atacar            
* los caminantes al tomar un lugar, a cada caminante lo va a atacar un              
* atacante cualquiera del grupo una sola vez. En caso de no poder, el             
* 1 grupo pierde al integrante más débil y los integrantes jodidos          
* (aquellos con resistencia menor a 40) pasan a estar infectados por           
* más que lo estuvieran ya. 
* iii) Finalmente, hacer todo lo que corresponda en el lugar tomado. 
* 
* grupo.tomarLugar(lugar) 
 
4) Personaje solitario
*  a) ¿Qué pasaría si hay un sobreviviente que no quiere trabajar en grupo, y             
*   quisiera tomar un lugar solo?  
* b) ¿Debería hacer cambios en su modelo de objetos? ¿Cualés?  
* c) ¿Qué concepto lo ayudaría con esto y por qué?  
 
 * Se podria declarar al sobreviviente como un grupo, y funcionaría, porque grupo entiende el mensaje atacar lugar,
 * o también se podría agregar el metodo tomarLugar(lugar). El concepto que me ayuda es el polimorfismo, ya que lo que 
 * sirve es que ambos objetos entiendan el mismo mensaje.
 */