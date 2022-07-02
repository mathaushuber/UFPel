function envoltoria_convexa = env_convexa(varargin)
%Gerando a imagem com a envoltória convexa a partir de uma imagem binária.
%env_convexa(imagem) calcula o fecho convexo de todos os objetos na imagem e
%retorna a imagem de fecho convexo binária. A imagem é uma imagem 2D
%lógica e o retorno é uma imagem de fecho convexo lógica, contendo a máscara binária do
%do fecho convexo de todos os objetos de primeiro plano na imagem.


[imagem, metodo, conn] = parseInputs(varargin{:});

% Rotulando a imagem
if strcmpi(metodo,'uniao')
    % Marcando todos os pixels 'verdadeiros' como uma única região
    labeled_image = uint8(imagem);
else
    % chamamos a função que calcula a envoltória convexa em cada celula
    labeled_image = bwconncomp(imagem,conn);
end

blob_props = regionprops(labeled_image,'BoundingBox','ConvexImage');
num_blobs = length(blob_props);
[linhas, colunas] = size(imagem);

%Fazendo um loop sobre todos os blobs obtendo o retorno para cada blob, um de cada vez, e 
%adicione para a imagem cumulativa.
envoltoria_convexa = false(linhas, colunas);
for i = 1 : num_blobs
    m = blob_props(i).BoundingBox(4);
    n = blob_props(i).BoundingBox(3);
    r1 = blob_props(i).BoundingBox(2) + 0.5;
    c1 = blob_props(i).BoundingBox(1) + 0.5;
    linhas = (1:m) + r1 - 1;
    cols = (1:n) + c1 - 1;
    envoltoria_convexa(linhas,cols) = envoltoria_convexa(linhas,cols) | blob_props(i).ConvexImage;
end


function [imagem,metodo,conn] = parseInputs(varargin)

narginchk(1,3);

imagem = varargin{1};
validateattributes(imagem, {'logical' 'numeric'}, {'2d', 'real', 'nonsparse'}, ...
    mfilename, 'imagem', 1);

if ~islogical(imagem)
    imagem = imagem ~= 0;
end

if nargin == 1
    % FechoConvexo(imagem)
    metodo = 'uniao';
    conn = 8;
    
elseif nargin == 2
    metodo = varargin{2};
    conn = 8;
    
else
    metodo = varargin{2};
    conn = varargin{3};
    
%especifica a conectividade desejada, usado ao definir objetos individuais em primeiro plano.
%Só é válido quando o método é 'leucocitos'. conn pode ter o seguindo os valores escalares:
%      4 : vizinhança de quatro conexões bidimensional 
%      8 : vizinhança de oito conexões bidimensional (padrão)
    % caso especial para que passemos pelo caminho do código 2D por 4 ou 8
    % conectividade
    if isequal(conn, [0 1 0;1 1 1;0 1 0])
        conn = 4;
    end
    if isequal(conn, ones(3))
        conn = 8;
    end
    
end

% validando as entradas
metodo = validatestring(metodo,{'uniao','leucocitos'},mfilename,'metodo',2);

% validando a conectividade
is_valid_scalar = isscalar(conn) && (conn == 4 || conn == 8);
if is_valid_scalar
    return
end

% Além disso, CONN pode ser definido de uma forma mais geral, usando um 3 por 3
% matriz de 0s e 1s. Os elementos de valor 1 definem a vizinhança, ou seja,
% as localizações relativas ao elemento central. CONN deve ser
% simétrica em relação ao seu elemento central.
% matriz 3x3
is_valid_matrix = isnumeric(conn) && isequal(size(conn),[3 3]);
% com todos os 1's e 0's.
is_valid_matrix = is_valid_matrix && all((conn(:) == 1) | (conn(:) == 0));
% cujo valor central é diferente de zero
is_valid_matrix = is_valid_matrix && conn((end+1)/2) ~= 0;
% e que é simétrico
is_valid_matrix = is_valid_matrix && isequal(conn(1:end), conn(end:-1:1));

if ~is_valid_matrix
    error(message('images:FechoConvexo:invalidConnectivity'))
end

