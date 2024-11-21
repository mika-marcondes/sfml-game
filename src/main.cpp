#include "imgui.h"
#include "imgui-SFML.h"

#include <SFML/Graphics/CircleShape.hpp>
#include <SFML/Graphics/RenderWindow.hpp>
#include <SFML/System/Clock.hpp>
#include <SFML/Window/Event.hpp>

int main()
{
    sf::RenderWindow window(sf::VideoMode({640, 480}), "ImGui + SFML = <3");
    window.setFramerateLimit(60);
    ImGui::SFML::Init(window);

    sf::Clock deltaClock;
    while (window.isOpen())
    {
        // Proccess Window Events (Close,Resize,etc...)
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                window.close();
            }

            ImGui::SFML::ProcessEvent(window, event);
        }

        // Imgui Update/Configure Draw (Begin<->End)
        ImGui::SFML::Update(window, deltaClock.restart());
        ImGui::Begin("Hello, world!");
        ImGui::Button("Look at this pretty button");
        ImGui::End();

        // SFML Window Draw cycle
        window.clear();
        {
            // SFML Draw Calls goes here
        }
        // Render the previous configured Imgui draw instructions
        ImGui::SFML::Render(window);
        window.display();
    }

    ImGui::SFML::Shutdown();
}
