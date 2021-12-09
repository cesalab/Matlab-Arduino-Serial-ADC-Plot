function Matlab_serial(numero_muestras)

    close all;
    clc;
    y=zeros(1,1000); %vector donde se guardaran los datos

    %inicializamos el puerto serial
    delete(instrfind({'Port'},{'COM17'}));
    puerto_serial = serial ('COM17');
    puerto_serial.BaudRate=9600;
    warning('off', 'MATLAB:serial:fscanf:unsuccessfulRead');

    %se abre puerto serial
    fopen(puerto_serial);

    %declararmos un contador del numero de muestras
    contador_muestras = 1;

    figure ('Name', 'Serial Communication. Jasa :)');
    title('Serial COMMUNICATION');
    xlabel('Numero de muestra');
    ylabel('Voltaje (V)');
    grid on;
    hold on;

    while contador_muestras <= numero_muestras
        ylim([0 5.1])
        xlim([contador_muestras-20 contador_muestras+5]);
        valor_potenciometro = fscanf(puerto_serial, '%d');
        y(contador_muestras)=(valor_potenciometro(1))*5/1024;
        plot(contador_muestras,y(contador_muestras),'X-r');
        drawnow
        contador_muestras=contador_muestras+1;
    end

    %cerramos conexion con puerto serial
    fclose(puerto_serial);
    delete(puerto_serial);
    clear all;

end