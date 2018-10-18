close all; clc; clear;

global iag x y npar
%% Configuracao Inicial
npar=20; % numero das variaveis para serem otimizadas (genes)
Nt=npar; % numero de colunas da matriz de populacao

x=rand(1,npar);
y=rand(1,npar); % cidades em (cidadeX, cidadeY)

% Adiciona o numero maximo de interacoes (Criterio de Parada)
maxit = 10000;  %TODO: Alterar isso aqui!

% Parametros do AG ???
% tamanho da populacao
tamPop = 20;
%indMut = 0.05 % taxa de mutacao (probabilidade de 0.05)
selecao=0.5; % fracao da populacao a ser mantida
manter=floor(selecao*tamPop); % numero de membros da populacao que sobrevivem
M=ceil((tamPop-manter)/2); % numero de cruzamentos

% calculo da probabilidade para a selecao dos pais
probab=1; %probabilidade
for ii=2:manter
    probab=[probab ii*ones(1,ii)];
end
Nprobab=length(probab);
probab=manter-probab+1; 

% Gerar a populacao inicial
iag=0; % contador para iniciar a geracao
% gerar a populacao aleatoria (Veja funcao randperm)
for i = 1:20
    populacao(i,:) = randperm(20);
endfor;
% deve ser uma matriz 20x20 (cromossomo + n. da populacao)

%calcular o custo da populacao utilizando a funcao de aptidao
dist = cvfun(populacao);
% colocar o custo minimo no elemento 1 (Veja funcao sort)
%k = custos organizados
%m = indices dos custos
[k,m] = sort(dist);
% organizar a populacao com o custo mais baixo primeiro
populacao = populacao(m,:);

%% Interacao pelas geracoes (LOOP PRINCIPAL)
while iag<maxit
    iag=iag+1; % incrementa o contador de geracoes
    
    % Escolha do Pai1 e Pa2 que são escolhidos aleatoriamente do vetor
    % probab
    escolha1=ceil(Nprobab*rand(1,M)); % escolher aleatoriamente na roleta os indivíduos
    escolha2=ceil(Nprobab*rand(1,M)); % escolher aleatoriamente na roleta os indivíduos
  
    indPai1=probab(escolha1); % selecionar os indices escolhidos na roleta para o pai 1
    indPai2=probab(escolha2); % selecionar os indices escolhidos na roleta para o pai 2
    
    indSub = 11;  %indice da população que será substituido 
    % Execucao da Recombinacao (crossover)
    for ic = 1:M
        %seleciona o Pai 1
        pai1 = populacao(indPai1(ic),:);
        %seleciona o Pai 2 
        pai2 = populacao(indPai2(ic),:);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % CYCLE
        %
        % Faz a técnica de recombinação Cycle
        
        %busca indice aleátorio entre 1 e 20
        ind = ceil(rand*20); %pega numero aleatorio entre 1 e 20        
                
        %Faz a troca do indice aleátorio entre os pais 1 e 2
        numTemp = pai2(1,ind);  %guarda numero do pai 2
        pai2(1,ind) = pai1(ind);  %subtitui no pai 2
        pai1(1,ind) = numTemp;  %substitui no pai 1
        
        indAnterior = ind;        
        while (length(find(pai1==numTemp)) > 1) % busca os elementos repetidos( numTemp ) dentro do pai
          indDuplicado = find(pai1==numTemp);
          
          % faz o if para não pegar o mesmo indice da iteração anterior
          if (indDuplicado(1) == indAnterior)
            ind = indDuplicado(2);
          else 
            ind = indDuplicado(1);
          endif  
            
          numTemp = pai2(1,ind);  %guarda numero do pai 2
          pai2(1,ind) = pai1(ind);  %subtitui no pai 2
          pai1(1,ind) = numTemp;  %substitui no pai 1                    
          indAnterior = ind;
        endwhile;
        % FIM CYCLE
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        % Faz a Mutacao da populacao
        [paiMutacao1, paiMutacao2] = mutacao (pai1, pai2);
        
        populacao(indSub,:) = paiMutacao1;
        indSub = indSub + 1;
        populacao(indSub,:) = paiMutacao2;        
        indSub = indSub + 1;
    endfor;
     
   
    % Se calcula um novo custo para a nova população
    dist = cvfun(populacao);
    %_______________________________________________________
    % Organiza em ordem crescente os custos e associa aos parametros
    % colocar o custo minimo no elemento 1
    %k = custos organizados
    %m = indices dos custos
    [k,m] = sort(dist);
    % organizar a populacao com o custo mais baixo primeiro
    populacao = populacao(m,:);

end %iga


%_______________________________________________________
% Mostrar os resultados
figure(1);
plot([x(populacao(1,:)) x(populacao(1,1))], [y(populacao(1,:)) y(populacao(1,1))],x,y,'*');
axis square;
