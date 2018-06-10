function [ output ] = findnash( ptable )

a=zeros(1,length(ptable{1,2})); 
a(1)=1;
for i=1:size(ptable,1) % add lookup column to finding nash equilibrium
   ptable{i,3}=a; 
end

for i=2:length(ptable{1,1})% loop for every agent ***** don't forget to change i=2 for fix center node
    seen=zeros(size(ptable,1),1);%seen sate= 1 / unseen state= 0
    for j=1:size(ptable,1) % loop for every state
      if(seen(j,1)==0)
         state=ptable{j,1};
         state2=state;
         if(state2(i)=='1')
           state2(i)='0'; 
         else
           state2(i)='1';
         end
         index=find(strcmp(ptable(:,1),state2));
         payoff1=ptable{j,2};
         payoff2=ptable{index,2};
         if(payoff1(i)>payoff2(i))%find pure better strategy for state and agent i
            ptable{j,3}(i)=1;
         elseif(payoff1(i)==payoff2(i))
             ptable{index,3}(i)=1;
             ptable{j,3}(i)=1;
         else
             ptable{index,3}(i)=1;    
         end
        
          seen([j index],1)=1; % change to seen
      end
        
    end
  

end
%  nash=ptable{find(ptable(:,3)==ones(1,length(ptable{1,1}))),[1 2]};
%  output=nash;
index=[];
for i=1:size(ptable,1)   
    if(isequal(ptable{i,3},ones(1,length(ptable{1,1}))))
    index=horzcat(index,i);
    end
end
nash=ptable(index',[1 2]);
output=nash;
end

