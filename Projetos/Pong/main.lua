ball = {
    x = 400,
    y = 300,
    radius = 10,
    vx = 250,
    vy = 250
}

player = {
    x = 20,
    y = 150,
    width = 20,
    height = 80
}

enemy = {
    x = 760,
    y = 150,
    width = 20,
    height = 80
}

playerScore = 0
enemyScore = 0

function love.load()
    love.window.setTitle("Pong")
end

function love.update(dt)
    local playerSpeed = 300
    local enemySpeed = 250

    -- Movimento do jogador
    if love.keyboard.isDown("w") then
        player.y = player.y - playerSpeed * dt
    end

    if love.keyboard.isDown("s") then
        player.y = player.y + playerSpeed * dt
    end

    local enemySpeed = 300

    if love.keyboard.isDown("up") then
        enemy.y = enemy.y - enemySpeed * dt
    end

    if love.keyboard.isDown("down") then
        enemy.y = enemy.y + enemySpeed * dt
    end


    -- Movimento da bola
    ball.x = ball.x + ball.vx * dt
    ball.y = ball.y + ball.vy * dt
    -- Colisão com jogador
    if checkCollision(ball, player) then
        ball.x = player.x + player.width + ball.radius
        ball.vx = -ball.vx * 1.05
    end

    -- Colisão com inimigo
    if checkCollision(ball, enemy) then
        ball.x = enemy.x - ball.radius
        ball.vx = -ball.vx * 1.05
    end

    -- Colisão com teto
    if ball.y - ball.radius <= 0 then
        ball.y = ball.radius
        ball.vy = -ball.vy
    end

    -- Colisão com chão
    if ball.y + ball.radius >= love.graphics.getHeight() then
        ball.y = love.graphics.getHeight() - ball.radius
        ball.vy = -ball.vy
    end

    -- Limites do jogador
    if player.y < 0 then
        player.y = 0
    end

    if player.y + player.height > love.graphics.getHeight() then
        player.y = love.graphics.getHeight() - player.height
    end

    -- Limites do inimigo
    if enemy.y < 0 then
        enemy.y = 0
    end

    if enemy.y + enemy.height > love.graphics.getHeight() then
        enemy.y = love.graphics.getHeight() - enemy.height
    end

    -- Pontuação
    if ball.x < 0 then
        enemyScore = enemyScore + 1
        resetBall(-1)
    end

    if ball.x > love.graphics.getWidth() then
        playerScore = playerScore + 1
        resetBall(1)
    end
end
function love.draw()
    -- Bola
    love.graphics.circle(
        "fill",
        ball.x,
        ball.y,
        ball.radius
    )

    -- Jogador
    love.graphics.rectangle(
        "fill",
        player.x,
        player.y,
        player.width,
        player.height
    )

    -- Inimigo
    love.graphics.rectangle(
        "fill",
        enemy.x,
        enemy.y,
        enemy.width,
        enemy.height
    )

    -- Linha central
    love.graphics.line(
        love.graphics.getWidth() / 2,
        0,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight()
    )

    -- Placar
    love.graphics.print(
        playerScore,
        love.graphics.getWidth() / 2 - 50,
        20
    )

    love.graphics.print(
        enemyScore,
        love.graphics.getWidth() / 2 + 50,
        20
    )
end

function checkCollision(ball, paddle)
    return
        ball.x - ball.radius < paddle.x + paddle.width and
        ball.x + ball.radius > paddle.x and
        ball.y - ball.radius < paddle.y + paddle.height and
        ball.y + ball.radius > paddle.y
end

function resetBall(direction)
    ball.x = love.graphics.getWidth() / 2
    ball.y = love.graphics.getHeight() / 2

    ball.vx = 250 * direction

    if math.random(0, 1) == 0 then
        ball.vy = math.random(-250, -100)
    else
        ball.vy = math.random(100, 250)
    end
end