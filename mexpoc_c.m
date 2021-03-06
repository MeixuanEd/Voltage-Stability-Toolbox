function mexfuncname=mexpoc_c(pathname,filename,Yred)
%Creates C_code from Maple equation file, filename, that compiles 
%as a MEX-function. mexfilename is the name of the C_code file. 
%The inputs: filename and pathname can be obtained using uigetfile
% 

clear mex;
in_filename='model.src';
mexfilename=filename;
mexfuncname=mexfilename(1:length(mexfilename)-2);
%---------------------------------------
t=clock;
% load maple model
procread('model.src');
maple('model(0):')
'load maple model'
etime(clock,t)

% set up equations - define data, states, parameters, null space vector, compute Jacobians 
procread('mclas_pc.src');
t=clock;
dummy_var=0;
[zrow,zcol,Sred]=find(Yred);
F=maple('mclas_pc',zrow,zcol);
'classical model'
etime(clock,t)

procread('mclasord.src');
procread('mc_subop.src');
% Will optimize ExpLimit expressions at a time
ExpLimit=2000;
%ExpLimit=12000;
%ExpLimit=0;
t=clock;
% join columns F, J
dimensions=double(sym(maple('mclasord',ExpLimit)));
'reordered model'
etime(clock,t)
t=clock;
% optimizes expressons in groups of size ExpLimit
lengths=double(sym(maple('mc_subop',ExpLimit,dimensions(1),dimensions(2),dimensions(3))));
'suboptimized model'
etime(clock,t)
fid=fopen([pathname,mexfilename],'wt');
%------------------------- write header of C program -------------
fprintf(fid,'/*\n');
fprintf(fid,'   The calling syntax is:\n');
fprintf(fid,['          [f,J] = ',mexfuncname,'(data,x,param,v)\n']);
fprintf(fid,'*/\n\n');
fprintf(fid,'#include <math.h>\n');
fprintf(fid,'#include "mex.h"\n\n');

fprintf(fid,'static\n');
fprintf(fid,'#ifdef __STDC__\n');
fprintf(fid,['void ',mexfuncname,'(\n']);
fprintf(fid,'                           double  f[],\n');
fprintf(fid,'                           double  J[],\n');
fprintf(fid,'                           double  data[],\n');
fprintf(fid,'                           double  x[],\n');
fprintf(fid,'                           double  param[],\n');
fprintf(fid,'                           double  v[]\n');
fprintf(fid,'                     )\n');
fprintf(fid,'#else\n');
fprintf(fid,[mexfuncname,'(f,J,data,x,param,v)\n']);
fprintf(fid,'double             f[],J[];\n');
fprintf(fid,'double             data[],x[],param[],v[];\n');
fprintf(fid,'#endif\n\n');
fprintf(fid,'/*      Computational Routine    */\n');
fprintf(fid,'{\n');

%-------------- write  variable declaration and optimized C code ------
%tmp_var=maple('templist;');
%[tv,tmp_var]=strtok(tmp_var,'t');
%[tmp_var,tv]=strtok(tmp_var,']');
%while ~isempty(tmp_var),
%  [tv,tmp_var]=strtok(tmp_var,',');
%  fprintf(fid,'        double   %s;\n',tv);
%end
lengths
remainder=lengths(2)
while remainder>0
        tv=maple(['seq(templist[ii+',num2str(lengths(2)-remainder,8),'],ii=1..min(10,',num2str(remainder,8),'));']);
%       tv=maple('seq(templist[ii+lengths(2)-remainder],ii=1..min(10,remainder));');
        fprintf(fid,'   double   %s;\n',tv);
        remainder=remainder-10;
end;
fprintf(fid,'\n');
fprintf(fid,'   double   %s;\n','s1, s2, s3, s4, s5, s6, s7, s8, s9, s10');
fprintf(fid,'\n');
fclose(fid);
%------- write C code ---------------
maple('gc:');
maple('readlib(C):');
'C lib installed'

maple('interface(screenwidth=8000)');
procread('cwrite.src');
procread('cwriteln.src');

procread('c_conv.src');
t=clock;

fid=fopen([pathname,mexfilename],'a+');
NumExp=10;

remainder=lengths(1)
while remainder>0
        nd=fprintf(fid,'%s \n', maplemex(['c_conv(',num2str(min(NumExp,remainder),8),',',num2str(lengths(1)-remainder,8),'):']));
        remainder=remainder-NumExp;          
end;

fclose(fid);

'write C code'
etime(clock,t)
%------ write the end of computational routine and the begining of gateway routine ---------------------
fid=fopen([pathname,mexfilename],'a+');
fprintf(fid,'\n');
fprintf(fid,'   return;\n');
fprintf(fid,'}\n\n');
fprintf(fid,'/*         Gateway Routine         */\n\n');

fprintf(fid,'void mexFunction(\n');
fprintf(fid,'   int             nlhs,\n');
fprintf(fid,'   mxArray  *plhs[],\n');
fprintf(fid,'   int             nrhs,\n');
fprintf(fid,'   const mxArray  *prhs[]\n');
fprintf(fid,'   )\n');

fprintf(fid,'{\n');
fprintf(fid,'   double          *f;\n');
fprintf(fid,'   double          *J;\n');
fprintf(fid,'   double          *data;\n');
fprintf(fid,'   double          *x;\n');
fprintf(fid,'   double          *param;\n');
fprintf(fid,'   double          *v;\n');
fprintf(fid,'   /* Create a matrix for the return argument */\n\n');

%------------------ write the output matrix dimension ------------
fprintf(fid,'   plhs[0] = mxCreateDoubleMatrix(%4i, 1, mxREAL);\n\n',dimensions(1));
fprintf(fid,'   plhs[1] = mxCreateDoubleMatrix(%4i,%4i, mxREAL);\n\n',dimensions(2),dimensions(3));

%------------------ write the end of gateway routine ----------------
fprintf(fid,'   /* Assign pointers to the various parameters */\n\n');
fprintf(fid,'   f = mxGetPr(plhs[0]);\n\n');
fprintf(fid,'   J = mxGetPr(plhs[1]);\n\n');
fprintf(fid,'   data = mxGetPr(prhs[0]);\n');
fprintf(fid,'   x = mxGetPr(prhs[1]);\n');
fprintf(fid,'   param = mxGetPr(prhs[2]);\n');
fprintf(fid,'   v = mxGetPr(prhs[3]);\n');
fprintf(fid,'   /* Do the actual computations in a subroutine */\n\n');
fprintf(fid,['  ',mexfuncname,'(f,J,data,x,param,v);\n']);
fprintf(fid,'   return;\n');
fprintf(fid,'}\n');

fclose(fid);

