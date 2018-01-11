% Inaccurate method of interpolation

    % identifies the gridpoints adjacent to the source point
    Corner1 = [floor(Sx) floor(Sy)];
    Corner2 = [ceil(Sx) floor(Sy)];
    Corner3 = [floor(Sx) ceil(Sy)];
    Corner4 = [ceil(Sx) ceil(Sy)];
    
    % finds the distances from the source point to the gridpoints
    Sd1 = sqrt((Sx - Corner1(1))^2 + (Sy - Corner1(2))^2);
    Sd2 = sqrt((Corner2(1) - Sx)^2 + (Sy - Corner2(2))^2);
    Sd3 = sqrt((Sx - Corner3(1))^2 + (Corner3(2) - Sy)^2);
    Sd4 = sqrt((Corner4(1) - Sx)^2 + (Corner4(2) - Sy)^2);

    % finds "percent" distance of source point from each gridpoint and
    % finds the amount of CO_2 input at gridpoints
    S1 = 1-(Sd1/sqrt(2));
    S2 = 1-(Sd2/sqrt(2));
    S3 = 1-(Sd3/sqrt(2));
    S4 = 1-(Sd4/sqrt(2));
        
    percent0 = S1 + S2 + S3 + S4;
    
    S1 = (S1/percent0)*S;
    S2 = (S2/percent0)*S;
    S3 = (S3/percent0)*S;
    S4 = (S4/percent0)*S;
    
    % redefines the amount of concentration at the gridpoints
    C(floor(Sx),floor(Sy)) = C(floor(Sx),floor(Sy))+ S1;
    C(ceil(Sx),floor(Sy)) = C(ceil(Sx),floor(Sy))+ S2;
    C(floor(Sx),ceil(Sy)) = C(floor(Sx),ceil(Sy))+ S3;
    C(ceil(Sx),ceil(Sy)) = C(ceil(Sx),ceil(Sy))+ S4;