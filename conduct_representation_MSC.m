
%%This code is related to the fig 2 and fig 3
allsignals = load('master\MSC-Signals428.mat');
allsignals = allsignals.allsignals;
rois = size(allsignals,2);
timepoints = size(allsignals,1);

msc_state_entropy = zeros(rois,10,10);
msc_dynamic = zeros(rois,10,10);
msc_state_switch =  zeros(rois,10,10);

msc_pearsonr = zeros(nchoosek(rois,2),10,10);
msc_equivalence = zeros(nchoosek(rois,2),10,10);
msc_equivalence_dynamic = zeros(nchoosek(rois,2),10,10);
msc_equivalence_stable = zeros(nchoosek(rois,2),10,10);

DIs_entropy = zeros(length(1:1:99),1);
DIs_dynamic = zeros(length(1:1:99),1);
DIs_stable = zeros(length(1:1:99),1);
DIs_equivalence = zeros(length(1:1:99),1);
%% Loop through thresholds to obtain all DIs
for thresh = 1:1:99
    fprintf('Thresh is %d\n',thresh)
for sub = 1:10
    for i = 1 : 10
        brainsignals = allsignals(:,:,i,sub);
        [~,sub_Fy] = gradient(brainsignals);
     
        raws = sub_Fy;
        diff_signals = abs(raws);
        ptcs = prctile(diff_signals',thresh);
        s1 = (raws > 0) & (diff_signals >  ptcs');
        s4 = (raws <= 0) & (diff_signals > ptcs');
        s2 = (raws > 0) & (diff_signals <= ptcs');
        s3 = (raws <= 0) & (diff_signals <= ptcs');
        states = s1 + 2*s2 + 3*s3 + 4*s4;
        [~,msc_dynamic(:,i,sub),msc_state_entropy(:,i,sub)] = W_dysentropy(states);
        
    end
end
new = reshape(msc_state_entropy,rois,100);
similarity_entropy = corr(new,'Type','Spearman');
[DI,within,between] = W_calculate_DI(similarity_entropy);
DIs_entropy(thresh,1) =  DI;
end

%% DI scores under different scanning ratio
ratios = 0.1:0.1:1;
DIs_time_effecy_entropy = zeros(length(ratios),1);
DIs_time_effecy_dynamic = zeros(length(ratios),1);
DIs_time_effecy_switch = zeros(length(ratios),1);

DIs_time_effecy_pearson =  zeros(length(ratios),1);
DIs_time_effecy_equivalence = zeros(length(ratios),1);
DIs_time_effecy_equivalence_dynamic = zeros(length(ratios),1);
DIs_time_effecy_equivalence_stable = zeros(length(ratios),1);

time = 0;
thresh = 57;
for ratio = 0.1:0.1:1
    ratio
    time = time + 1;
    for sub = 1:10
        for i = 1 : 10
            
            brainsignals = allsignals(1:ceil(818*ratio),:,i,sub);
            timepoints = size(brainsignals,1);
            
            [~,sub_Fy] = gradient(brainsignals);
            diff_signals = abs(sub_Fy);
            ptcs = prctile(diff_signals',thresh);
            
            s1 = (sub_Fy > 0) & (diff_signals >  ptcs');
            s4 = (sub_Fy <= 0) & (diff_signals > ptcs');
            s2 = (sub_Fy > 0) & (diff_signals <= ptcs');
            s3 = (sub_Fy <= 0) & (diff_signals <= ptcs');
            dynamic_states = s1 + s4;
            states = s1 + 2*s2 + 3*s3 + 4*s4;
            
            diff_states = diff(dynamic_states);
            diff_states(diff_states ~= 0) = 1;
            msc_state_switch(:,i,sub) = sum(diff_states)/(timepoints-1);
            [~,msc_dynamic(:,i,sub),msc_state_entropy(:,i,sub)] = W_dysentropy(states);
            [msc_equivalence_stable(:,i,sub),msc_equivalence_dynamic(:,i,sub)] = W_state_cooccurence(states,1);
            fc_mat = atanh(corr(brainsignals) - eye(rois,rois));
            msc_pearsonr(:,i,sub) =squareform(fc_mat);
            
            msc_equivalence(:,i,sub) = W_state_equivalence(states,1);
            
            
        end
    end
    tmp = reshape(msc_state_entropy,rois,100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_entropy(time,1) = W_calculate_DI(similarity);
    
    tmp = reshape(msc_dynamic,rois,100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_dynamic(time,1) = W_calculate_DI(similarity);
    
    tmp = reshape(msc_state_switch,rois,100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_switch(time,1) = W_calculate_DI(similarity);
    
    tmp = reshape(msc_pearsonr,nchoosek(rois,2),100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_pearson(time,1) = W_calculate_DI(similarity);
    
    tmp = reshape(msc_equivalence,nchoosek(rois,2),100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_equivalence(time,1) = W_calculate_DI(similarity);
    
    tmp = reshape(msc_equivalence_dynamic,nchoosek(rois,2),100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_equivalence_dynamic(time,1) = W_calculate_DI(similarity);
    
    tmp = reshape(msc_equivalence_stable,nchoosek(rois,2),100);
    similarity = corr(tmp,'Type','Spearman');
    DIs_time_effecy_equivalence_stable(time,1) = W_calculate_DI(similarity);
end

plot(0.1 :0.1:1,DIs_time_effecy_entropy,'LineWidth',1.5,'Color',[0.6350 0.0780 0.1840],'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
hold on
plot(0.1 :0.1:1,DIs_time_effecy_dynamic,'LineWidth',1.5,'Color',[70, 105, 149]/255,'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
hold on
plot(0.1 :0.1:1,DIs_time_effecy_switch,'LineWidth',1.5,'Color',[38, 135, 133]/255,'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
xlabel('Scanning ratio','FontName','Arial')
ylabel('Differential identifiability','FontName','Arial')
set(gca,'FontName','Arial','FontSize',16,'XGrid','on','YGrid','on');

plot(0.1 :0.1:1,DIs_time_effecy_pearson,'LineWidth',1.5,'Color',[112 126 114]./255,'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
hold on
plot(0.1 :0.1:1,DIs_time_effecy_equivalence,'LineWidth',1.5,'Color',[127,200,202]./255,'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
hold on
plot(0.1 :0.1:1,DIs_time_effecy_equivalence_dynamic,'LineWidth',1.5,'Color',[244,111,67]./255,'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
hold on
plot(0.1 :0.1:1,DIs_time_effecy_equivalence_stable,'LineWidth',1.5,'Color',[251,221,133]./255,'Marker','o','MarkerFaceColor','w');set(gca,'FontSize',12)
xlabel('Scanning ratio','FontName','Arial','FontSize',14)
ylabel('Differential identifiability','FontName','Arial','FontSize',14)
set(gca,'FontName','Arial','FontSize',16,'XGrid','on','YGrid','on');

