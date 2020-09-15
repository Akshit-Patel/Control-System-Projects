function cost= optimize(k)
    assignin('base','k',k);
    sim('GA.slx');
    out = evalin('base','out');
    cost = out.ITAE.Data(length(out.ITAE.Data));
end