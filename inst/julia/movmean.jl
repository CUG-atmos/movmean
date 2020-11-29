using Statistics

function movmean(x::AbstractArray{Union{Missing, T}, 1},  halfwin::Integer = 2) where {T <: Real}
    # NA and Inf will automatically ignored
    n = length(x)
    z = zeros(n)
    
    # is_valid = isfinite.(x) .& (.!ismissing.(x))
    @inbounds for i = 1:n
        i_begin = i <= halfwin ? 1 : i - halfwin
        i_end = i <= n - halfwin ? i + halfwin : n
        
        val = 0.0; len = 0;
        @inbounds for j in i_begin:i_end
            if !ismissing(x[j]) & isfinite(x[j])
                val += x[j];
                len += 1;
            end
        end 
        # ind_raw = (i_begin:i_end)
        # ind = ind_raw[is_valid[ind_raw]]
        if len > 0
            z[i] = val/len
        else
            z[i] = missing
        end
    end
    z
end

function movmean(x::AbstractArray{T, 1}, halfwin::Integer = 2) where {T <: Real}
    n = length(x)
    z = zeros(n)
    for i = 1:n
        i_begin = i <= halfwin ? 1 : i - halfwin
        i_end = i <= n - halfwin ? i + halfwin : n
        # println((i_begin, i_end))
        z[i] = mean(@view x[i_begin:i_end])
    end
    z
end

weightedMean(x::AbstractArray{T, 1}, w::AbstractArray{T2, 1}) where {T <: Real, T2 <: Real} = sum(x .* w) / sum(w)

# 4 times slower
function movmean(x::AbstractArray{T, 1}, w::AbstractArray{T2, 1}, halfwin::Integer = 2) where {T <: Real, T2 <: Real}
    n = length(x)
    z = zeros(n)
    for i = 1:n
        i_begin = i <= halfwin ? 1 : i - halfwin
        i_end = i <= n - halfwin ? i + halfwin : n

        # println((i_begin, i_end))
        z[i] = weightedMean(view(x, i_begin:i_end), view(w, i_begin:i_end))
        # z[i] = weightedMean(x[i_begin:i_end], w[i_begin:i_end])
        # z[i] = sum(view(x, i_begin:i_end) .* view(w, i_begin:i_end)) / sum(view(w, i_begin:i_end))
    end
    z
end


export movmean, weightedMean

# using RCall
# R"""
# x = c(NA, 1, 2, 3, Inf)
# """
# @rget x
# movmean(x)
