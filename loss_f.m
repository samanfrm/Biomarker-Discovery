function [ output ] = loss_f( state )

nonz=0;
for i=1:length(state)
  if(strcmp(state(i),'1'))
     nonz=nonz+1; 
  end
end
output=nonz / length(state);
end

