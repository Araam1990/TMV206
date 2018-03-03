% CID
% jacped
% vikfran
% ellenwi
% tankred
% ostcarl

A = [3 5; 1 8];

% eig(A) = [2.1459 ; 8.8541]

power_iteration(A, 6);

function power_iteration(A, p)
    iterations = 0;

    % initieringen av bk (b0)
    bk = rand(length(A), 1);
    
    % Rayleigh quotient (egenvärdet)
    eig = (bk.'*A*bk) / (bk.'*bk);
    
    % ser till att while-loopen alltid körs åtminstone en gång
    e = 10^(-p) + 1;

    while (e > 10^(-p))
        % räknar ut nästa bk
        bk = (A*bk) / (norm(A*bk));
        
        % räknar ut nästa Rayleigh Quotient
        eig_next = (bk.'*A*bk) / (bk.'*bk);

        % räknar ut skillnaden mellan nya och förra RQ
        e = norm(eig - eig_next);
        
        % uppdaterar RQ
        eig = eig_next;

        iterations = iterations + 1;
    end

    iterations
    bk
    eig
end

