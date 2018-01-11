%Multiply a given sparse band matrix by a vector
function r = BandMatrixMult(bands,M,v)
  %Apply diagonal band
  r = v.*bands(:,1);
  %Apply lower diagonal band
  r = r + v([end,1:end-1]).*bands(:,2);
  %Apply upper diagonal band
  r = r + v([2:end,1]).*bands(:,3);
  %Apply far lower diagonal band
  r = r + v([(end-(M-1)):end,1:end-M]).*bands(:,4);
  %Apply far upper diagonal band
  r = r + v([(M+1):end,1:M]).*bands(:,5);
end