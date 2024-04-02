class ArticlesController < ActionController::Base

    def show
        @artigo = Article.find(params[:id])
    end

end
