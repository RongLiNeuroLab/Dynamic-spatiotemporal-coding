load('E:\Scientific work\Work2\State coding\Result\lifespan_rsfa.mat')
load('E:\Scientific work\Work2\State coding\Result\lifespan_switch.mat')
load('E:\Scientific work\Work2\State coding\Result\lifespan_dynamics.mat')
load('E:\Scientific work\Work2\State coding\Result\lifespan_entropy.mat')

load('E:\Scientific work\Work2\State coding\Result\lifespan_equivalence_dynamic.mat')
load('E:\Scientific work\Work2\State coding\Result\lifespan_equivalence_stable.mat')
load('E:\Scientific work\Work2\State coding\Result\lifespan_equivalence.mat')
load('E:\Scientific work\Work2\State coding\Result\lifespan_pearson_r.mat')

lifespan_data = xlsread('E:\Scientific work\Work2\State coding\Slim_lifespan\subjects438-information.xlsx');
lifespan_age = lifespan_data(:,3);

lifespan_entropy_35 = lifespan_state_entropy(lifespan_age<35,:);
lifespan_dynamic_35 = lifespan_dynamic(lifespan_age<35,:);
lifespan_switch_35 = lifespan_state_switch(lifespan_age<35,:);
lifespan_rsfa_35 = lifespan_rsfa(lifespan_age<35,:);


lifespan_pearson_r_35 = lifespan_pearson_r(lifespan_age<35,:);
lifespan_equivalence_35 = lifespan_equivalence(lifespan_age<35,:);
lifespan_equivalence_dynamic_35 = lifespan_equivalence_dynamic(lifespan_age<35,:);
lifespan_equivalence_stable_35 = lifespan_equivalence_stable(lifespan_age<35,:);

rsfa_35_group = mean(lifespan_rsfa_35);
entropy_35_group = mean(lifespan_entropy_35);
switch_35_group = mean(lifespan_switch_35);
dynamic_35_group = mean(lifespan_dynamic_35);
pearson_35_group = mean(lifespan_pearson_r_35);
equivalence_35_group = mean(lifespan_equivalence_35);
dynamic_equivalence_35_group = mean(lifespan_equivalence_dynamic_35);
stable_equivalence_35_group = mean(lifespan_equivalence_stable_35);

save('E:\Scientific work\Work2\State coding\Result\SALD1_rsfa.mat','rsfa_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_entropy.mat','entropy_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_switch.mat','switch_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_dynamic.mat','dynamic_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_pearson.mat','pearson_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_equivalence.mat','equivalence_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_dynamic_equivalence.mat','dynamic_equivalence_35_group')
save('E:\Scientific work\Work2\State coding\Result\SALD1_stable_equivalence.mat','stable_equivalence_35_group')

mdl1 = fitlm(log(rsfa_35_group),dynamic_35_group,'poly1');
x= min(rsfa_35_group):0.01:max(rsfa_35_group);
ypred = predict(mdl1,log(x'));
scatter(rsfa_35_group',dynamic_35_group,80,...
'LineWidth',0.0001,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[244,111,67]./255);hold on;
plot(x,ypred,'Color','k','LineWidth',0.8);
xlabel('RSFA'); ylabel('State dynamics')
set(gca,'FontName','Arial','FontSize',18,'XGrid','on','YGrid','on');

x1 = min(rsfa_35_group):0.01:mean(rsfa_35_group);
x2 = mean(rsfa_35_group):0.01:max(rsfa_35_group);
rsfa35_1 = rsfa_35_group(rsfa_35_group < mean(rsfa_35_group));
rsfa35_2 = rsfa_35_group(rsfa_35_group >= mean(rsfa_35_group));
entropy35_1 = entropy_35_group(rsfa_35_group < mean(rsfa_35_group));
entropy35_2 = entropy_35_group(rsfa_35_group >= mean(rsfa_35_group));
mdl1 = fitlm(rsfa35_1,entropy35_1,'poly3');
mdl2 = fitlm(rsfa35_2,entropy35_2,'poly2');
ypred1 = predict(mdl1,x1');
ypred2 = predict(mdl2,x2');
scatter(rsfa_35_group',entropy_35_group,45,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[127,200,202]./255);hold on;
plot(x1,ypred1,'Color','k','LineWidth',1.5);hold on;plot(x2,ypred2,'Color','k','LineWidth',1.5);hold on;
xline(mean(rsfa_35_group),'--','LineWidth',1.5);yline(max(entropy_35_group),'--','LineWidth',1.5);
xlabel('RSFA'); ylabel('State entropy');
set(gca,'FontName','Arial','FontSize',18,'XGrid','on','YGrid','on');
[r,p] = corr(rsfa35_1',entropy35_1');
fprintf('r value is %f, p value is %f\n',r,p)
[r,p] = corr(rsfa35_2',entropy35_2');
fprintf('r value is %f, p value is %f\n',r,p)

switch35_1 = switch_35_group(rsfa_35_group < mean(rsfa_35_group));
switch35_2 = switch_35_group(rsfa_35_group >= mean(rsfa_35_group));
mdl1 = fitlm(rsfa35_1,switch35_1,'poly2');
mdl2 = fitlm(rsfa35_2,switch35_2,'poly2');
ypred1 = predict(mdl1,x1');
ypred2 = predict(mdl2,x2');
scatter(rsfa_35_group',switch_35_group,45,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[251,221,133]./255);hold on;
plot(x1,ypred1,'Color','k','LineWidth',1.5);hold on;plot(x2,ypred2,'Color','k','LineWidth',1.5);hold on;
xline(mean(rsfa_35_group),'--','LineWidth',1.5);yline(max(switch_35_group),'--','LineWidth',1.5);
xlabel('RSFA'); ylabel('Switch rate');
set(gca,'FontName','Arial','FontSize',18,'XGrid','on','YGrid','on');

[r,p] = corr(rsfa35_1',switch35_1');
fprintf('r value is %f, p value is %f\n',r,p)
[r,p] = corr(rsfa35_2',switch35_2');
fprintf('r value is %f, p value is %f\n',r,p)

x = min(pearson_35_group):0.01:max(pearson_35_group);
mdl = fitlm(pearson_35_group,equivalence_35_group,'poly2');
ypred = predict(mdl,x');
scatter(pearson_35_group,equivalence_35_group,45,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[244,111,67]./255);hold on;
plot(x,ypred,'Color','k','LineWidth',1.5);
xlabel('Pearson FC'); ylabel('State equivalence')
set(gca,'FontName','Arial','FontSize',18,'XGrid','on','YGrid','on');

mdl = fitlm(pearson_35_group,stable_equivalence_35_group,'poly2');
ypred = predict(mdl,x');
scatter(pearson_35_group,stable_equivalence_35_group,45,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[251,221,133]./255);hold on;
plot(x,ypred,'Color','k','LineWidth',1.5);
xlabel('Pearson FC'); ylabel('Stable equivalence')
set(gca,'FontName','Arial','FontSize',18,'XGrid','on','YGrid','on');

mdl = fitlm(pearson_35_group,dynamic_equivalence_35_group,'poly3');
ypred = predict(mdl,x');
scatter(pearson_35_group,dynamic_equivalence_35_group,45,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor',[127,200,202]./255);hold on;
plot(x,ypred,'Color','k','LineWidth',1.5);
xlabel('Pearson FC'); ylabel('Dynamic equivalence')
set(gca,'FontName','Arial','FontSize',18,'XGrid','on','YGrid','on');


