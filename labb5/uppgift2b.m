% Grupp 8
% CID
% jacped
% vikfran
% ellenwi
% tankred
% ostcarl

A = [3 5; 1 8];

% eig(A) = [2.1459 ; 8.8541]

inverse_iteration(A, 6, 2)

function out = inverse_iteration(A, p, r)
    iterations = 0;

    % initieringen av bk (b0)
    bk = rand(length(A), 1);

    % Rayleigh Quotient (egenvärde)
    eig = bk.'*A*bk/(bk.'*bk);

    % enhetsmatris av godtycklig storlek
    I = eye(length(A));

    % ett värde som ser till att loopen körs åtminstone en gång
    e = 10^(-p) + 1;

    while (e > 10^(-p))
        % räknar ut konstanten Ck
        Ck = norm((inv((A - (r * I))) * bk))

        % räknar ut nästa bk
        bk = (inv((A - (r * I))) * bk) / Ck;

        % räknar ut nästa Rayleigh Quotient
        eig_next = bk.'*A*bk/(bk.'*bk);

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

