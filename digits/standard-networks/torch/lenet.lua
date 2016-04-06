
-- return function that returns network definition
return function(params)
    -- get number of classes from external parameters
    local nclasses = params.nclasses or 1

    -- get number of channels from external parameters
    local channels = 1
    -- params.inputShape may be nil during visualization
    if params.inputShape then
        channels = params.inputShape[1]
        assert(params.inputShape[2]==28 and params.inputShape[3]==28, 'Network expects 28x28 images')
    end

    if pcall(function() require('cudnn') end) then
       print('Using CuDNN backend')
       backend = cudnn
       convLayer = cudnn.SpatialConvolution
       convLayerName = 'cudnn.SpatialConvolution'
    else
       print('Failed to load cudnn backend (is libcudnn.so in your library path?)')
       if pcall(function() require('cunn') end) then
           print('Falling back to legacy cunn backend')
       else
           print('Failed to load cunn backend (is CUDA installed?)')
           print('Falling back to legacy nn backend')
       end
       backend = nn -- works with cunn or nn
       convLayer = nn.SpatialConvolutionMM
       convLayerName = 'nn.SpatialConvolutionMM'
    end

    -- -- This is a LeNet model. For more information: http://yann.lecun.com/exdb/lenet/

    local lenet = nn.Sequential()
    lenet:add(nn.MulConstant(0.00390625))
    lenet:add(backend.SpatialConvolution(channels,20,5,5,1,1,0)) -- channels*28*28 -> 20*24*24
    lenet:add(backend.SpatialMaxPooling(2, 2, 2, 2)) -- 20*24*24 -> 20*12*12
    lenet:add(backend.SpatialConvolution(20,50,5,5,1,1,0)) -- 20*12*12 -> 50*8*8
    lenet:add(backend.SpatialMaxPooling(2,2,2,2)) --  50*8*8 -> 50*4*4
    lenet:add(nn.View(-1):setNumInputDims(3))  -- 50*4*4 -> 800
    lenet:add(nn.Linear(800,500))  -- 800 -> 500
    lenet:add(backend.ReLU())
    lenet:add(nn.Linear(500, nclasses))  -- 500 -> nclasses
    lenet:add(nn.LogSoftMax())

    local model
    if params.ngpus > 1 then
       model = nn.DataParallelTable(1)  -- Split along first (batch) dimension
       for i = 1, params.ngpus do
          cutorch.setDevice(i)
          model:add(lenet:clone(), i)  -- Use the ith GPU
       end
       cutorch.setDevice(1)  -- This is the 'primary' GPU
       model.gradInput = nil
    else
       model = lenet
    end

    return {
        model = model,
        loss = nn.ClassNLLCriterion(),
        trainBatchSize = 64,
        validationBatchSize = 100,
    }
end

