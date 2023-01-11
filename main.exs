defmodule Poker do
  def card(num) do
    x=num
    value = cond do
      rem(x, 13) == 1 -> 14
      true -> rem(x, 13)
    end
    value= cond do
      value==0 -> 13
      true -> value
    end
    cond do 
      1<=x && x<=13 -> {value, "C"}
      14<=x && x<=26 -> {value, "D"}
      27<=x && x<=39 -> {value, "H"}
      40<=x && x<=52 -> {value, "S"}
    end
  end

  def pair(lst) do
    copy=lst
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    pairs=Enum.filter(lst, fn(m) -> y=(elem m, 0); Enum.count(values, fn(n) -> n==y end)==2 end)
    cond do
      Enum.count(pairs) >0 -> 
        one=hd(pairs)
        two=hd(tl(pairs))
        copy=copy -- [one, two]
        {true, {one, two, hd(copy)}, 2}
      true -> {false}
    end
  end

  def twopair(lst) do
    copy=lst
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    pairs=Enum.filter(lst, fn(m) -> y=(elem m, 0); Enum.count(values, fn(n) -> n==y end)==2 end)
    cond do
      Enum.count(pairs) >3 -> 
        one=hd(pairs)
        two=hd(tl(pairs))
        three=hd(tl(tl(pairs)))
        four=hd(tl(tl(tl(pairs))))
        copy=copy -- [one, two, three, four]
        {true, {one, two, three, four, hd(copy)}, 3}
      true -> {false}
    end
  end

  def threeof(lst) do
    copy=lst
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    pairs=Enum.filter(lst, fn(m) -> y=(elem m, 0); Enum.count(values, fn(n) -> n==y end)==3 end)
    cond do
      Enum.count(pairs) >0 -> 
        one=hd(pairs)
        two=hd(tl(pairs))
        three=hd(tl(tl(pairs)))
        copy=copy -- [one, two, three]
        {true, {one, two, three, hd(copy)}, 4}
      true -> {false}
    end
  end

  def straight(lst) do
    _copy=lst
    one=hd(lst)
    two=hd(tl(lst))
    three=hd(tl(tl(lst)))
    four=hd(tl(tl(tl(lst))))
    five=hd(tl(tl(tl(tl(lst)))))
    six=hd(tl(tl(tl(tl(tl(lst))))))
    seven=hd(tl(tl(tl(tl(tl(tl(lst)))))))
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    values1=(values -- [Enum.at(values, 5)]) -- [Enum.at(values, 6)]
    values2=(values -- [Enum.at(values, 0)]) -- [Enum.at(values, 6)]
    values3=(values -- [Enum.at(values, 0)]) -- [Enum.at(values, 1)]
    values4=(values3 -- [Enum.at(values3, 0)]) ++ [1]
    first=Enum.at(values, 0)
    second=Enum.at(values, 1)
    third=Enum.at(values, 2)
    straight1=[first, first-1, first-2, first-3, first-4]
    straight2=[second, second-1, second-2, second-3, second-4]
    straight3=[third, third-1, third-2, third-3, third-4]
    straight4=[5, 4, 3, 2, 1]
    cond do
      values1==straight1 -> 
        {true, {one, two, three, four, five}, 5}
      values2==straight2 -> 
        {true, {two, three, four, five, six}, 5}
      values3==straight3 -> 
        {true, {three, four, five, six, seven}, 5}
      (values4==straight4 && hd(values) ==14) -> 
        {true, {four, five, six, seven, one}, 5}
      true -> {false}
    end 
  end
    
  def flush(lst) do
    _copy=lst
    values=Enum.map(lst, fn(n) -> (elem n, 1) end)
    pairs=Enum.filter(lst, fn(m) -> y=(elem m, 1); Enum.count(values, fn(n) -> n==y end)>=5 end)
    cond do
      Enum.count(pairs) >=5 -> 
        one=hd(pairs)
        two=hd(tl(pairs))
        three=hd(tl(tl(pairs)))
        four=hd(tl(tl(tl(pairs))))
        five=hd(tl(tl(tl(tl(pairs)))))
        {true, {one, two, three, four, five}, 6}
      true -> {false}
    end
  end

  def fullhouse(lst) do
    copy=lst
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    pairs=Enum.filter(lst, fn(m) -> y=(elem m, 0); Enum.count(values, fn(n) -> n==y end)==3 end)
    copy=copy -- pairs 
    pairs2=Enum.filter(copy, fn(m) -> y=(elem m, 0); Enum.count(values, fn(n) -> n==y end)>=2 end)
    cond do
      (Enum.count(pairs) >0 && Enum.count(pairs2)>0) -> 
        one=hd(pairs)
        two=hd(tl(pairs))
        three=hd(tl(tl(pairs)))
        four=hd(pairs2)
        five=hd(tl(pairs2))
        {true, {one, two, three, four, five}, 7}
      true -> {false}
    end
  end

  def fourof(lst) do
    copy=lst
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    pairs=Enum.filter(lst, fn(m) -> y=(elem m, 0); Enum.count(values, fn(n) -> n==y end)==4 end)
    cond do
      Enum.count(pairs) >0 -> 
        one=hd(pairs)
        two=hd(tl(pairs))
        three=hd(tl(tl(pairs)))
        four=hd(tl(tl(tl(pairs))))
        copy=copy -- [one, two, three, four]
        {true, {one, two, three, four, hd(copy)}, 8}
      true -> {false}
    end
  end

  def straightflush(lst) do
    _copy=lst
    one=hd(lst)
    two=hd(tl(lst))
    three=hd(tl(tl(lst)))
    four=hd(tl(tl(tl(lst))))
    five=hd(tl(tl(tl(tl(lst)))))
    six=hd(tl(tl(tl(tl(tl(lst))))))
    seven=hd(tl(tl(tl(tl(tl(tl(lst)))))))
    lst1=[one, two, three, four, five]
    lst2=[two, three, four, five, six]
    lst3=[three, four, five, six, seven]
    lst4=[four, five, six, seven, one]
    suit1=Enum.map(lst1, fn(n) -> (elem n, 1) end)
    pairs1=Enum.filter(lst1, fn(m) -> y=(elem m, 1); Enum.count(suit1, fn(n) -> n==y end)>=5 end)
    suit2=Enum.map(lst2, fn(n) -> (elem n, 1) end)
    pairs2=Enum.filter(lst2, fn(m) -> y=(elem m, 1); Enum.count(suit2, fn(n) -> n==y end)>=5 end)
    suit3=Enum.map(lst1, fn(n) -> (elem n, 1) end)
    pairs3=Enum.filter(lst3, fn(m) -> y=(elem m, 1); Enum.count(suit3, fn(n) -> n==y end)>=5 end)
    suit4=Enum.map(lst4, fn(n) -> (elem n, 1) end)
    pairs4=Enum.filter(lst4, fn(m) -> y=(elem m, 1); Enum.count(suit4, fn(n) -> n==y end)>=5 end)
    values=Enum.map(lst, fn(n) -> (elem n, 0) end)
    values1=(values -- [Enum.at(values, 5)]) -- [Enum.at(values, 6)]
    values2=(values -- [Enum.at(values, 0)]) -- [Enum.at(values, 6)]
    values3=(values -- [Enum.at(values, 0)]) -- [Enum.at(values, 1)]
    values4=(values3 -- [Enum.at(values3, 0)]) ++ [1]
    first=Enum.at(values, 0)
    second=Enum.at(values, 1)
    third=Enum.at(values, 2)
    straight1=[first, first-1, first-2, first-3, first-4]
    straight2=[second, second-1, second-2, second-3, second-4]
    straight3=[third, third-1, third-2, third-3, third-4]
    straight4=[5, 4, 3, 2, 1]
    cond do
      (values1==straight1 && Enum.count(pairs1) >=5) -> 
        {true, {one, two, three, four, five}, 9}
      (values2==straight2 && Enum.count(pairs2) >=5) -> 
        {true, {two, three, four, five, six}, 9}
      (values3==straight3 && Enum.count(pairs3) >=5) -> 
        {true, {three, four, five, six, seven}, 9}
      (values4==straight4 && hd(values) ==14 && Enum.count(pairs4) >=5) -> 
        {true, {four, five, six, seven, one}, 9}
      true -> {false}
    end 
  end

  def royalflush(lst) do
    x=straightflush(lst)
    cond do
      (elem x,0) == true -> 
        y=(elem x, 1)
        z=(elem y, 0)
        cond do
          (elem z,0) == 14 -> {true, y, 10}
          true -> {false}
        end
      true -> {false} 
    end
  end

  def evaluate(lst) do
    cond do
      (elem royalflush(lst), 0) == true ->
        royalflush(lst)
      (elem straightflush(lst), 0) == true ->
        straightflush(lst)
      (elem fourof(lst), 0) == true ->
        fourof(lst)
      (elem fullhouse(lst), 0) == true ->
        fullhouse(lst)
      (elem flush(lst), 0) == true ->
        flush(lst)
      (elem straight(lst), 0) == true ->
        straight(lst)
      (elem threeof(lst), 0) == true ->
        threeof(lst)
      (elem twopair(lst), 0) == true ->
        twopair(lst)
      (elem pair(lst), 0) == true ->
        pair(lst)
      true -> {true, {hd(lst), hd(tl(lst))}, 1}
    end
  end

  def power(x) do
    elem x, 2
  end

  def cards(x) do
    elem x, 1
  end

  def getcard(lst, num) do
    card=elem lst, num
    elem card, 0
  end

  def compare(h1, h2) do
    cond do
      power(h1) > power(h2) -> [cards(h1), 0, power(h1)]
      power(h1) < power(h2) -> [cards(h2), 0, power(h2)]
      getcard(cards(h1), 0) > getcard(cards(h2), 0) ->
        [cards(h1), 1, power(h1)]
      getcard(cards(h1), 0) < getcard(cards(h2), 0) ->
        [cards(h2), 1, power(h1)]
      getcard(cards(h1), 1) > getcard(cards(h2), 1) ->
        [cards(h1), 2, power(h1)]
      getcard(cards(h1), 1) < getcard(cards(h2), 1) ->
        [cards(h2), 2, power(h1)]
      getcard(cards(h1), 2) > getcard(cards(h2), 2) ->
        [cards(h1), 3, power(h1)]
      getcard(cards(h1), 2) < getcard(cards(h2), 2) ->
        [cards(h2), 3, power(h1)]
      getcard(cards(h1), 3) > getcard(cards(h2), 3) ->
        [cards(h1), 4, power(h1)]
      getcard(cards(h1), 3) < getcard(cards(h2), 3) ->
        [cards(h2), 4, power(h1)]
      getcard(cards(h1), 4) > getcard(cards(h2), 3) ->
        [cards(h1), 5, power(h1)]
      getcard(cards(h1), 2) < getcard(cards(h2), 2) ->
        [cards(h2), 5, power(h1)]
    end
  end

  def str(c) do
    lst= Tuple.to_list(c)
    cond do
      hd(lst)<14 -> Enum.join([Integer.to_string(hd(lst)), hd(tl(lst))])
      true -> Enum.join(["1", hd(tl(lst))])
    end
  end

  def deal(lst) do
    one = [hd(lst), hd(tl(tl(lst)))] ++ tl(tl(tl(tl(lst))))
    two = [hd(tl(lst))] ++ tl(tl(tl(lst)))
    cards1 = Stream.map(one, fn(n) -> card(n) end)
    cards1 = Enum.sort_by(cards1, fn(r) -> elem r, 0 end, &>=/2)
    hand1 = evaluate(cards1)
    cards2 = Stream.map(two, fn(n) -> card(n) end)
    cards2 = Enum.sort_by(cards2, fn(r) -> elem r, 0 end, &>=/2)
    hand2 = evaluate(cards2)
    win=compare(hand1, hand2)
    winner=
      cond do
       (tuple_size(hd win) > hd(tl(win))) && ( hd(tl(tl(win)))==8 || hd(tl(tl(win)))==4 || hd(tl(tl(win)))==3 || hd(tl(tl(win)))==2 || hd(tl(tl(win)))==1 )->
          Tuple.delete_at((hd win), tuple_size(hd win)-1)
        true -> hd win
      end
    final= Tuple.to_list(winner)
    Enum.map(final, fn(n) -> str(n) end)
  end
end
IO.inspect(Poker.deal [ 11, 2, 3, 4, 8, 39, 20, 45, 49 ])