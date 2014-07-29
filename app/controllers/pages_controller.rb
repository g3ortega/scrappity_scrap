class PagesController < ApplicationController
  def index
  end

  def sentimiento
    term = get_terms_from_params[0..1]
    @sentiments = Articulo.get_sentiment_data(term)
    @categories = @sentiments.keys


    @series = {}

    @sentiments.values.each_with_index do |value, index|

      Articulo::VALUES_SENTIMENT.each_with_index do |value, i|
        if @series[@sentiments.values[index].keys[i]].nil?
          @series[@sentiments.values[index].keys[i]] = []
        end

      end
      # terms.each_with_index do |v, i|
      #   if @series[@sentiments.values[index].keys[i]].nil?
      #     @series[@sentiments.values[index].keys[i]] = []
      #   end
      #
      #   @series[@sentiments.values[index].keys[i]] << @sentiments.values[index].values[i]
      #
      # end

    end
    # render :json => {:title => terms.join(", "), :series => Articulo.get_topics_data(terms)}

  end

  def correlacion
    terms = get_terms_from_params
    @topics = Articulo.get_topics_data(terms)

    @series = {}

    cant_topics = @topics.values.each_with_index do |value, index|
       terms.each_with_index do |v, i|
         if @series[@topics.values[index].keys[i]].nil?
           @series[@topics.values[index].keys[i]] = []
         end

         @series[@topics.values[index].keys[i]] << @topics.values[index].values[i]

       end

    end

  end

  def query
    terms = get_terms_from_params
    render :json => {:title => terms.join(", "), :series => Articulo.get_topics_data(terms)}
  end

  private

  def get_terms_from_params
    params[:q].to_s.split(",").map{ |t| t.squish.remove_punctuation }.select(&:present?).uniq
  end



end

