    tmp_fig=gcf;

    uicontrol(tmp_fig,...
        'Style','frame',...
        'BackgroundColor','b',...
        'Position',[25,195,5*90+15,110]);  % EDITED BY: Vedanshu

    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[30,200,95,18],...
        'HorizontalAlignment','Left',...
        'String','MaxIterations',...
        'BackgroundColor',[0.7 0.7 0.7]);
     
    MaxIterationControl=uicontrol(tmp_fig,...
        'Style','edit',...
        'Position',[125,200,75,18],...
        'HorizontalAlignment','Right',...
        'String',num2str(20),...
        'Callback','lfcntrup');

    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[200,200,90,18],...
        'HorizontalAlignment','Left',...
        'String','Reporting');
    ReportControl=uicontrol(tmp_fig,...
        'Style','edit',...
        'Position',[290,200,75,18],...
        'HorizontalAlignment','Right',...
        'String',num2str(5),...
        'Callback','lfcntrup');

    uicontrol(tmp_fig,...
        'Style','pushbutton',...
        'BackgroundColor','g',...
        'Position',[370,200,55,18],...
        'HorizontalAlignment','Center',...
        'String','Start',...
        'Callback','spcomp_NR_NRS');
     
     %uicontrol(tmp_fig,...
      %  'Style','pushbutton',...
       % 'BackgroundColor','r',...
       % 'Position',[430,200,55,18],...
       % 'HorizontalAlignment','Center',...
       % 'String','Reset',...
       % 'Callback','spreset');

      
         
    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[30,220,95,18],...
        'HorizontalAlignment','Left',...
        'String','Error');
    AbsErrorDisp=uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[126,220,74,18],...
        'HorizontalAlignment','Center',...
        'String','NA');

    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[200,220,90,18],...
        'HorizontalAlignment','left',...
        'String','RelError');
    RelErrorDisp=uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[291,220,74,18],...
        'HorizontalAlignment','Center',...
        'String','NA');

    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[30,240,95,18],...
        'HorizontalAlignment','Left',...
        'String','Tolerence');
    AbsTolControl=uicontrol(tmp_fig,...
        'Style','edit',...
        'Position',[125,240,75,18],...
        'HorizontalAlignment','Right',...
        'String',num2str(LFAbsTol,5),...
        'Callback','lfcntrup');

    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[200,240,90,18],...
        'HorizontalAlignment','Left',...
        'String','RelTolerence');
    RelTolControl=uicontrol(tmp_fig,...
        'Style','edit',...
        'Position',[290,240,75,18],...
        'HorizontalAlignment','Right',...
        'String',num2str(LFRelTol,5),...
        'Callback','lfcntrup');

    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[30,285,223,18],...
        'HorizontalAlignment','Center',...
        'String','Algorithm');

    %******************************
    % Iterations box
    %******************************
    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[258,285,111,18],...
        'HorizontalAlignment','Center',...
        'String','Iterations');
    NumIterations=uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[370,285,100,18],...
        'BackgroundColor','y',...
        'HorizontalAlignment','Center',...
        'String','0');
     
    %******************************
    % NR and NRS Step size box
    %******************************
    
    	 uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[370,240,75,18],...
        'HorizontalAlignment','Left',...
        'String','NR_steps');
    NR_stepControl=uicontrol(tmp_fig,...
        'Style','edit',...
        'Position',[430,240,55,18],...
        'HorizontalAlignment','Right',...
        'String',num2str(NR_steps,5),...
        'Callback','lfcntrup1');
        
         uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[370,220,75,18],...
        'HorizontalAlignment','Left',...
        'String','NRS_Steps');
    NRS_stepControl=uicontrol(tmp_fig,...
        'Style','edit',...
        'Position',[430,220,55,18],...
        'HorizontalAlignment','Right',...
        'String',num2str(NRS_Steps,5),...
        'Callback','lfcntrup1');
    %******************************
    % Elapsed Time box
    %******************************
    uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[258,265,111,18],...
        'HorizontalAlignment','Center',...
        'String','Time/Iteration');
    IterationTime=uicontrol(tmp_fig,...
        'Style','text',...
        'Position',[370,265,100,18],...
        'BackgroundColor','y',...
        'HorizontalAlignment','Center',...
        'String','0');