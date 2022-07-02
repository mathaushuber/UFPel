function cc = comp_conectividade(varargin)
[BW, conn] = parseInputs(varargin{:});

CC = struct(...
    'Connectivity', conn, ...
    'ImageSize', size(BW), ...
    'NumObjects', [], ...
    'PixelIdxList', []);

if ismatrix(BW) && (isequal(conn,4) || isequal(conn,8))
    [CC.PixelIdxList,CC.NumObjects] = bwconncomp_2d(BW, conn);
else
    [CC.PixelIdxList,CC.NumObjects] = bwconncomp_nd(BW, conn);
end

%--------------------------------------------------------------------------
function [BW,conn] = parseInputs(varargin)

narginchk(1,2);

BW = varargin{1};
validateattributes(BW, {'logical' 'numeric'}, {'real', 'nonsparse'}, ...
              mfilename, 'BW', 1);
if ~islogical(BW)
    BW = BW ~= 0;
end

if nargin < 2

    if ismatrix(BW)
        conn = 8;
    elseif ndims(BW) == 3
        conn = 26;
    else
        conn = conndef(ndims(BW), 'maximal');
    end
else
    conn = varargin{2};
    iptcheckconn(conn,mfilename,'CONN',2);
   
    if isequal(conn, [0 1 0;1 1 1;0 1 0])
        conn = 4;
    end
    if isequal(conn, ones(3))
        conn = 8;
    end
end