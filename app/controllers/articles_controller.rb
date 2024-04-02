class ArticlesController < ActionController::Base

    def show
        @artigo = Article.find(params[:id])
    end

    def index
        @artigos = Article.all
        
    end

end
