A_title = load('data/title.mat');
A_title = A_title.rs;
B_title = load('data/title_den.mat');
B_title = B_title.rs;

A_tag = load('data/tag.mat');
A_tag = A_tag.rs;
B_tag = load('data/tag_den.mat');
B_tag = B_tag.rs;

A_year = load('data/year.mat');
A_year = A_year.rs;
B_year = load('data/year_den.mat');
B_year = B_year.rs;

A_genre = load('data/genre.mat');
A_genre = A_genre.rs;
B_genre = load('data/genre_den.mat');
B_genre = B_genre.rs;

realRatings  = load('data/real_rating.mat');
realRatings = realRatings.real_rating;
tbl = table(A_title, A_tag, A_year, A_genre,...
            B_title, B_tag, B_year, B_genre, realRatings);
modelfun = @(b,x)(b(1).*x(:,1) + b(2).*x(:,2) +  b(3).*x(:,3) +  b(4).*x(:,4))...
                                     ./...
                 (b(1).*x(:,5) + b(2).*x(:,6) +  b(3).*x(:,7) +  b(4).*x(:,8) + 1e-9);
beta0 = [1 1 1 1];
mdl = fitnlm(tbl,modelfun,beta0)

%% Test with specific params
x = [A_title, A_tag, A_year, A_genre,...
            B_title, B_tag, B_year, B_genre, realRatings];
b = [32.726 0.33067 0.50134 0.44417];
modelfun = (b(1).*x(:,1) + b(2).*x(:,2) +  b(3).*x(:,3) +  b(4).*x(:,4))...
                                     ./...
                 (b(1).*x(:,5) + b(2).*x(:,6) +  b(3).*x(:,7) +  b(4).*x(:,8));
rmse = (sum((realRatings - modelfun).^2)/length(realRatings)).^0.5