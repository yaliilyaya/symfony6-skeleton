<?php


namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Class DefaultController
 * @package RosatomProcedures\DataAdmin\Controller
 */
class DefaultController extends AbstractController
{
    #[Route("/", name: "homepage")]
    public function index(): Response
    {
        return $this->render('mainPage.html.twig',[]);
    }

    #[Route("/flash/send", name: "flash.send")]
    public function sendFlash() : Response
    {
        $this->addFlash('success', "Привет!");

        return $this->redirectToRoute('homepage');
    }
}